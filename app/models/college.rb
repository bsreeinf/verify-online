class College < ActiveRecord::Base

# Associations
belongs_to :user
has_one :report_datum


end
