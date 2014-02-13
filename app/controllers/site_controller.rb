# encoding: utf-8
class SiteController < ApplicationController

  before_filter :set_title, except: :services

  def services
   @services = OrderType.active.all
  end

  private
  def set_title
    @title = {
      index:          'Экспертный калькулятор',
      about:          'Идея проекта',
      howto:          'Как это работает',
      pravila_photo:  'Правила фотографирования',
      payment:        'Как оплатить',
      contacts:       'О компании',
      documents:      'Нормативные документы'
    }[params[:action].to_sym]
  end

end

