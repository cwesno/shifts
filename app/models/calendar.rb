class Calendar < ActiveRecord::Base
  has_many :shifts
  has_many :time_slots
  has_many :repeating_events
  belongs_to :department

  validates_presence_of :name
  validates_presence_of :start_date
  validates_presence_of :end_date, :if => Proc.new{|calendar| !calendar.default?}

  validates_uniqueness_of :name, :scope => :department_id

  named_scope :active, lambda {{ :conditions => {:active => true}}}

  def deactivate
    self.active = false
    TimeSlot.update_all("active = #{false.to_sql}", "calendar_id = #{self.id.to_sql}")
    Shift.update_all("active = #{false.to_sql}", "calendar_id = #{self.id.to_sql}")
    self.save
  end

  def activate
    self.active = true
    conflicts = Shift.check_for_conflicts(Shift.find(:all, :conditions => ["calendar_id = #{self.id.to_sql} AND start > #{Time.now.utc.to_sql}"])) + TimeSlot.check_for_conflicts(TimeSlot.find(:all, :conditions=>["calendar_id = #{self.id.to_sql} AND start > #{Time.now.utc.to_sql}"]))
    if conflicts.empty?
      TimeSlot.update_all("active = #{true.to_sql}", "calendar_id = #{self.id.to_sql} AND start > #{Time.now.utc.to_sql}")
      Shift.update_all("active = #{true.to_sql}", "calendar_id = #{self.id.to_sql} AND start > #{Time.now.utc.to_sql}")
      self.save
      return false
    else
      return conflicts
    end
  end

end
