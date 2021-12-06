class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
	has_many :book_comments, dependent: :destroy

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
	scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
	scope :created_thisweek, -> { where(:created_at=> 6.day.ago..Time.now) }
	scope :created_lastweek, -> { where(:created_at=> 13.day.ago..7.day.ago) }

	scope :created_days_ago, ->(n) { where(created_at: n.days.ago.all_day) }

	def self.book_count
	 (0..6).map { |n| created_days_ago(n).count }.reverse
	end

	is_impressionable counter_cache: true

end
