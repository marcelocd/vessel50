module TrackingServices
  class Scraper < ApplicationService
    attr_reader :base_url, :agent

    def initialize base_url
      @base_url = base_url
      @agent    = Mechanize.new
    end

    def call
      print_ship
      scrape!
    end

    private

    def scrape!
      ('A'..'Z').each do |initial|
        current_page = get_page(initial, 1)
        last_page_number = scrape_last_page_number(current_page)

        log("LETTER #{initial}: SCRAPING PAGE 1 OF #{last_page_number}...")

        trackings_attributes = scrape_page_trackings_attributes(current_page)
        save_trackings!(trackings_attributes)

        (2..last_page_number).each do |page_number|
          log("LETTER #{initial}: SCRAPING PAGE #{page_number} OF #{last_page_number}...")

          wait_a_little_bit
          current_page = get_page(initial, page_number)
          trackings_attributes = scrape_page_trackings_attributes(current_page)
          save_trackings!(trackings_attributes)
        end
      end
      log('DONE!')
    end

    def save_trackings! trackings_attributes
      trackings_attributes.each do |attributes|
        tracking = build_tracking(attributes)
        tracking.save
      end
    end

    def build_tracking attributes
      tracking = Tracking.new(attributes.except(:vessel))
      vessel   = build_vessel(attributes[:vessel])
      tracking.vessel = vessel
      tracking
    end

    def build_vessel attributes
      vessel = Vessel.find_by_imo(attributes[:imo])
      return vessel if vessel.present?

      vessel             = Vessel.new(attributes.except(:vessel_type))
      vessel_type        = build_vessel_type(attributes[:vessel_type])
      vessel.vessel_type = vessel_type
      vessel
    end

    def build_vessel_type attributes
      vessel_type = VesselType.find_by_name(attributes[:name])
      return vessel_type if vessel_type.present?

      VesselType.new(attributes)
    end

    def scrape_last_page_number page
      page.css('.container:not(.alphabet-filter) .pagination li:last-child a')
          .attr('href')
          .value
          .match(/page=(\d+)/)[1]
          .to_i
    end

    def scrape_page_trackings_attributes page
      tracking_rows = page.css('.results-table .row')
      tracking_rows.map{ |row| scrape_row_tracking_attributes(row) }
    end

    def scrape_row_tracking_attributes row
      {
        vessel:    scrape_vessel_attributes(row),
        area:      row.css('.area').text.strip,
        last_seen: row.css('.last-received').text.strip
      }
    end

    def scrape_vessel_attributes row
      dimensions = row.css('.sizes').text.strip
      {
        vessel_type:   { name: row.css('.name-type .type').text.strip },
        name:          row.css('.name-type .name').text.strip,
        imo:           row.css('.imo').text.strip,
        callsign:      row.css('.callsign').text.strip,
        mmsi:          row.css('.mmsi').text.strip,
        length_meters: dimensions.match(/^([^xX]+)/)[1].to_f,
        width_meters:  dimensions.match(/[xX](.+)/)[1].to_f,
        image_url:     "https:#{row.css('.photo a img').attr('src').text.strip}"
      }
    end

    def get_page initial, page_number
      url = build_url(initial, page_number)
      Nokogiri::HTML(agent.get(url).body)
    end

    def build_url initial, page_number
      "#{base_url}?search=#{initial}&page=#{page_number}"
    end

    def wait_a_little_bit
      sleep(3)
    end

    def print_ship
      puts ''
      puts "                                          @%%%@
                                      @%*%%*=---=*##%%#%%
                                      %= +%=    +%=    -%
                                      %+ =%%:  ==*=+   .%
                                      @# -%%-  :+:-:    *%
                                      @%.:%%++***+=:...:*%          @%
                                       %..%@      %%%%%%@          @#+%%%%@
                                       %:.%@                       @*:%-:-*%%%%%%%@
              @%%@           @%#%%%%%%%%%%%%%%%%%%%%%              @%.%.  .....:#%
             @*:.+%          %##%+:::::::::::::::::-%@              %.##*######%@
             %+  =#=+%%%%%%%%   @%.                 .*%             %:*%
             %+  =+  .:--:=%@    %=                  .*%     %#%%%%%%%%%%%%%%%@
             %+  =#+**++*%%      %#.                  .%     @%%=            -%%
             %+  =%               %:                   *%       %.            .%%
        %%%%%##**#%%%%%@          %-                   +%       %=             -%
       @%...        ..=%          %-                   +%       %+             .%
        %:            +%          %:                  .%@       %*             .%
        %+            #%         @%.                  =%        %+             =%
        @#.          .%          %+   ....:-=====-:..:%         %: ....:---:...%@
         %:          :%          %..-+%%%#.-%@@%%%%%%%%%%      %*-*%%%##%%%%%##*%@
         %#*==----==+#%      @%%#*+**+==---::----==+#***%    %%%***#########*=-+%@
          %%%%*==*%%%%       %#%%++**####%##%%%#*+-:. :+%@   @%%+:--====--:.    :*%
             %+  =%             %+ ..::----::..         :#@    @%.               .+%
             %+  =%              %.        .:-==-:.      .*%    %:                .*%
             %+  =%              %=       .#%%%%%%%.       *%   %-                 :%
             %+  =%              %*       =%%%%%%%%+       .#@  %=                 .%@
             %+  =%              @#       :%::=#..*=        =%  %+                  #@
             %+  =%               %.   .:.:%**%+%##+ -*+.   .%  %+                 .%
             %+  =%               %.  .%%+..=%#+##..=%%#.    %@ %=                 =%
             %+  =%               %.  .#%%%#=:...-#%#+-:    .%  %=                .%@
             %+  =%               %.   .....-*%%#+:..       :%  %-    .:-=++++=-:.*%
             %+  =%               %.     -+*##=::-+%%%*     =% %%=+*++********##%%%
       %#====++==+**###%%%%%%%@   %.    .*%*:.     .-*-    .#% %%%%%%%%%=*%%@@@@
       %*=%#=-*+-:+=-:=-::-=-+%  @%      .-.               =%          %==%                     @@%%%
       %*=%%+=+=+=%%+=%%+=%%*+%  %#        .............  :%           %+-%               @@%##*=-::#%
       %*=%%+=*=+=%%+=%%+=%%*+%  %*    .-+*%%#%%%%%%%%%%*=%%           %*:%       @   %%%#+:.   .=#%%
     %#%%#%#****+=++=-++-:**=+% %%*=**+*******###%%%%%##%%%@           @#-%%%#*+--%#+-:...  .=*#%@
     %-  .....:::::-----=====++**%%%%%%%%%%%=.*%              @@%%%#*+==-::..    -*     .-+*%%
     %=...                      .*%        %+ +%           %*+=-::.         ..:-=#: .-+*%%
     %#++***+++++=====-----::::. :%@       %* =%          %#.     ...::-==++*+=-=#=*%%
     %+                 ...::-=*. :%%      @# -%         @#. .-=+*#*+-:.       .%@
     %*                       .=*. .#%      %.:%       @%+. .%:....            *%
     @#..                      .=*. .-#%@   %..%    @%%=.. -#:             ..-+%
      %%%##**++=-:..             :*-. .:=+#%%+=%%#*+=:.  :++.    ..:--=+++===+%
            %*::-=+++++====----::::+*-.    .....      .-*%+===+++++=-:..    -%@
             @%:.          .::--===+++#=:....  ....:-+*-:.                .-%
               %+.                      .=*%%%%%#*=:.                  .-+%%
                @#+=--::..                  ....            .::-=+*#*+=:-%@
                  %%+:----==========++++++++++++++++========---::...  .+%%
                    %#=.                                          .:-+%@
                      @%+:...                              ..::-=+%%%@
                         %%%%#*+==---:::..........::--==+*##*=-:+%%
                            @%%*-........:::::::............=#%%
                               @%%##*+=-::..    ...:-=+*###%%
                                     @@%%%%%%%%%%%%%%%@"
      puts ''
    end
  end
end
