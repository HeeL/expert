class UsersController < ApplicationController

 before_filter :require_no_user, :only => [:new, :create]
 before_filter :require_user, :only => [:account, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Ваш аккаунт создан!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end


  def index
    @users=User.find(:all)
  end

  def show
    @user = User.find(params[:id])
  end


  def edit
    @user = @current_user
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Изменения сохранены!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  def account
    @user = @current_user
    @orders=@user.orders
  end
end
