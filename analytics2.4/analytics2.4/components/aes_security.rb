require 'rubygems'
require 'ruby-aes'
require 'dbi'

class AESSecurity
  
  KEY_LENGTH = 128
  MODE = "OFB"
  
  SUCCESS=0
  USER_NOT_AUTHENTICATED=1000
  ENTITY_NOTALLOWED=3000
  GENERAL_FAILURE=4000
  
  #Setting the database username 
  USERNAME="root"
  #Setting the database password
  PASSWORD="mysql"
  #Setting the database name
  DATABASE="DBI:MYSQL:zestadz_analytics:192.168.0.15"
  
  #~ @@dc=nil
  #~ @@dc=DBI.connect(DATABASE, USERNAME, PASSWORD) if @@dc==nil
  
  attr_reader :key, :iv
  
  def initialize
      @key = ""
      @iv = ""
  end
  
  #method
  def generateKey(secretKey)
      begin
          @sk = secretKey
          @key = random_fill(16, @key, @sk)
          @iv = random_fill(16, @iv, @sk)
      rescue Exception => e
          puts "ERROR :: Security / generateKey :: #{e.to_s}"
      end
  end
  
  def encrypt(key,iv,value)
      begin
          str = Aes.encrypt_buffer(KEY_LENGTH, MODE, key, iv, value)
          ascii("#{str}")
      rescue Exception => e
          return nil
          puts "ERROR :: Security / encrypt :: #{e.to_s}"
      end
  end
  
  def decrypt(key,iv,code)
      begin
          value = character("#{code}")
          Aes.decrypt_buffer(KEY_LENGTH, MODE, key, iv, value) 
      rescue Exception => e
          return nil
          puts "ERROR :: Security / decrypt :: #{e.to_s}"
      end
  end
  
  #Name: checkSecurity
  #Purpose: Check user and entity security
  #version: 1.0
  #Last modified:04/06/07
  #This method is used to validate users, with their tokens and validate their access to the given entitiy.
  #An entity could be a controller, action, or even a component class 
  #Note: The token is recommended to be stored by the calling client method as a session or within the database
  def checkSecurity(userId,key,iv,roleId,entityId)
      begin
          #Getting the key which is generated when user logged
          #  @@dbconn = DBI.connect("DBI:MYSQL:zestadz_development:mw22", "zestadz", "hjtfjkk555454bhh")
          #check ont the key username and key right now
          #Need to modify this later
          
          userId = decrypt(key,iv,userId)
          #puts "this is user id - #{userId}"
          if userId == nil
              return ENTITY_NOTALLOWED
          else
              begin
                  sqlMain="select id, username, password, role_id from users where id='#{userId}' and role_id='#{roleId}'"
                  #~ if @@dc == nil
                  @dc=DBI.connect(DATABASE, USERNAME, PASSWORD)
                  #~ end
                  userDetails=@dc.select_one(sqlMain)
              rescue Exception=>e
                  return USER_NOT_AUTHENTICATED
              end
              
              if userDetails==nil
                  return ENTITY_NOTALLOWED
              else
                  if entityId==0
                      return SUCCESS
                  else
                      return SUCCESS
                  end
              end
          end
      rescue Exception =>e
          puts "ERROR :: Security / checkSecurity :: #{e.to_s}"
          return GENERAL_FAILURE
      ensure
          @dc.disconnect if @dc!=nil
          @dc=nil
      end
  end
  
  private
  def random_fill(n, buffer, sk)
      begin
          sk = sk.split("")
          n.times do 
            buffer << sk[rand(sk.size)]
          end
          return buffer
      rescue Exception => e
          puts "ERROR :: Security / random_fill :: #{e.to_s}"
      end
  end
  
  def ascii(str)
      begin
          code = ""
          str.each_byte do |s|
              code = "#{code}" + "#{s}-"
          end
          code = code.chop! if code!=""
          return code
      rescue Exception => e
          puts "ERROR :: Security / ascii :: #{e.to_s}"
      end
  end
  
  def character(code)
      begin
          str = ""
          value = code.split("-")
          for v in value
              str = "#{str}" + "#{v.to_i.chr}"
          end
          return str
      rescue Exception => e
          puts "ERROR :: Security / character :: #{e.to_s}"
      end
  end

end
