require 'rubygems'
require 'net/https'

class PagesController < ApplicationController
  
  def home
    @title = "Home"
    
    # oauth_key = 'HD5ZYV1DJSQE2FXEX32F54205X43WQ3W2LTEVORFD413OCAL'
    # oauth_secret = '1JGVNUDPLFNTDMLYA0I4DMW0ERPVYAFUMJAULLUJVCKHLBKP'

    oauth_key = 'client_id'
    oauth_secret = 'client_secret'
    
  end
  
end
