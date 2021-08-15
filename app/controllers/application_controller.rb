class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper #Sessionヘルパーモジュールを読み込む
end
