module ApplicationHelper
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
end
