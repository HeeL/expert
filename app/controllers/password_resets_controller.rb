# encoding: utf-8
class PasswordResetsController < ApplicationController
 before_filter :load_user_using_perishable_token, :only => [:edit, :update]  
 before_filter :require_no_user  

 def new
   @title="Восстановление пароля"
 end

 def create
   @user = User.find_by_email(params[:email])
   if @user
     @user.deliver_password_reset_instructions!
     flash[:notice] = "На ваш электронный адрес выслано письмо, которое поможет вам восстановить пароль!"
     redirect_to new_user_session_url
   else
     flash[:notice] = "Пользователь с таким e-mail не найден."
     render :action => :new
   end
 end


 def edit
   @title="Восстановление пароля"
   render
 end
   
 def update
   @user.password = params[:user][:password]
   if @user.save
     redirect_to account_url, :notice => "Пароль успешно изменен"
   else
     render :action => :edit
   end
 end

private  
 def load_user_using_perishable_token
   @user = User.find_using_perishable_token(params[:id])
   unless @user
     flash[:notice] = "К сожалению, определить пользователя не удалось. Попробуйте скопировать ссылку в окно браузера или повторить процедуру восстановления пароля."
     redirect_to root_path
   end
 end
end
