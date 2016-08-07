class Todo < ActiveRecord::Base
  scope :completed, -> () { where(completed: true)  }
  to_sync :completed do |scope, record|
    if record.completed
      scope << record
    else
      scope.delete(record)
    end
  end
  scope :active,    -> () { where(completed: false) }
  to_sync :active do |scope, record|
    if !record.completed
      scope << record
    else
      scope.delete(record)
    end
  end
end
