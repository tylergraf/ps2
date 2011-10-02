class Task < ActiveRecord::Base
  has_and_belongs_to_many :check_ins
  belongs_to :user

   validates :task, :presence => true,
                    :uniqueness => { :case_sensitive => false }
end
