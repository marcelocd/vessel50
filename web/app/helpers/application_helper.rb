module ApplicationHelper
  include Pagy::Frontend

  def css_files
    controller.css_files
  end

  def flash_method_class name
    {
      'success' => 'alert alert-success alert-dismissible fade show',
      'error'   => 'alert alert-danger alert-dismissible fade show',
      'warning' => 'alert alert-warning alert-dismissible fade show',
      'info'    => 'alert alert-primary alert-dismissible fade show',
      'notice'  => 'alert alert-success alert-dismissible fade show',
      'alert'   => 'alert alert-warning alert-dismissible fade show'
    }[name]
  end

  def sort_link label, sort_attribute, options = {}
    link_to(
      label,
      {
        sort:      sort_attribute,
        direction: ((params[:sort] == sort_attribute) && (params[:direction] == 'asc')) ? 'desc' : 'asc'
      }.merge(options)
    )
  end
end
