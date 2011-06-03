class Search < ActiveRecord::Base

  attr_accessible :name, :surname, :email, :type

  def users
    @users ||= find_users
  end

  private

  def find_users
    User.find(:all, :conditions => conditions)
  end

  def name_conditions
    ["users.name LIKE ?", "%#{name}%"] unless name.blank?
  end

  def surname_conditions
    ["users.surname LIKE ?", "%#{surname}%"] unless surname.blank?
  end

  def email_conditions
    ["users.email LIKE ?", "%#{email}%"] unless email.blank?
  end

  def conditions
    [conditions_clauses.join(' AND '), *conditions_options]
  end

  def conditions_clauses
    conditions_parts.map { |condition| condition.first }
  end

  def conditions_options
    conditions_parts.map { |condition| condition[1..-1] }.flatten
  end

  def conditions_parts
    private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
  end

end

