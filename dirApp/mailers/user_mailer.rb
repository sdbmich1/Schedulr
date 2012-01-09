class UserMailer < ActionMailer::Base
#  layout 'email'
  default :from => "webmaster@timemsgr.com"
  
  def welcome_email(user)
    @user = user
    @title = 'Koncierge'
    @url  = "http://localhost:3000/sign_in"
    mail(:to => "#{user.first_name} #{user.last_name} <#{user.email}>",
         :subject => "Welcome to #{@title}, #{user.username}!") 
  end
  
  def send_notice(email, notice, usr)
    @url  = root_url + "sign_up"
    @notice = notice; @user = usr
    mail(:to => "#{email}", :subject => "#{notice.title}: #{notice.start_date} @ #{notice.start_time} - #{notice.event_name}")     
  end

  def send_request(email, notice, usr)
    @url  = root_url + "sign_up"
    @notice = notice; @user = usr
    mail(:to => "#{email}", :subject => "#{notice.title}: #{notice.message}")        
  end
end
