# Copyright (C) 2005 Nick Hauenstein.
# This program is distributed under the terms of the GNU
# General Public License.
#
# This file is part of the xICE Software Development Kit.
#
# The xICE Software Development Kit is free software; you can
# redistribute it and/or modify it under the terms of the GNU
# General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your
# option) any later version.
#
# The xICE Software Development Kit is distributed in the
# hope that it will be useful, bu/t WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
#
# You should have received a copy of the GNU General Public
# License along with the xICE Software Development Kit; if
# not, write to the Free Software Foundation, Inc.,
# 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

# My handy VB to Ruby Pocket Dictionary
# -----------------------------------------------------------------
# VB                 Ruby              Notes
# Asc(strA)          = ?strA           Returns a hexadecimal number
# CStr(anything)     = anything.to_s
# Abs(number)        = number.abs
# Int(number)        = number.to_i
# strA + Chr(num)    = strA << num
# Asc(Mid(strA,i,1)) = strA[i]
# Mid(strA,i,1)      = strA[i,1]
# Len(strA)          = strA.length
# UCase(strA)        = strA.upcase
# CByte(varA)        = cByte(varA)     I wrote this method
# -----------------------------------------------------------------

# Please Note:
# This code uses a really weak time data. I would recommend changing
# this to something less easy to figure out. See the
# "Security Considerations" in the xICE Algorithm documentation for
# more information.
#
# Also I just learned Ruby yesterday, so the code isn't exactly as
# elegant as it could be

# xICE Engine - Ruby - v1.2
# 
# (nh)  1.0   First Release.
# (nh)  1.1   Fixed major bug in cryptographic functions to make more compatible
# (nh)  1.2   Added custom rounding functions to make more compatible. Still not perfect.
#
#  TODO: Make perfectly compatible with C++/VB versions
#
#  Note: The math included in this implementation is somewhat
#  fuzzy compared with others. This is not perfect, and should
#  not be treated as stable and/or used in a production environment.
#
#

require "bigdecimal"
require "bigdecimal/math.rb"
include BigMath

class XICE

  # All the magic numbers a boy could ever wish for!

  # Don't be fooled by IntBlockSize, it doesn't mean XICE is a block
  # cipher. It is simply the number of bytes to read in from the file at
  # a time for speed purposes. If we load in the whole file at once it
  # takes up a lot of memory and loads slowly, but processes fast because
  # it's in RAM. If we do it 1 byte at a time, it uses hardly any memory
  # but it processes really slow. The tradeoff is to load a chunk at a time.
  # It doesn't take too long to load the chunk, and once it's loaded we
  # can work with the data really quickly in the RAM.

  DblMultiplier = 1e13
  IntBlockSize = 524288
  SngPi = BigDecimal(3.14159265358979.to_s)
  SngMaxUpper = 2147483647
  SngMaxLower = -2147483648
  ErrInvalidKeyLength = 65101
  ErrInvalidKey = 65102
  ErrInvalidSize = 65103
  ErrFileNotFound = 65201
  ErrEmptyFile = 65202
  ErrInvalidFileSize = 65203
  ErrSameFile = 65204
  ErrKeyMissing = 65303
  ErrInputFileMissing = 65301
  ErrOutputFileMissing = 65302
  ErrClearTextMissing = 65304
  ErrCipherTextMissing = 65305
  
  attr_reader :dblCenterX, :dblCenterY, :lastResult, :lastErrNum, :lastErrDes

  def initialize()

    @dblCenterX = BigDecimal(0.to_s)
    @dblCenterY = BigDecimal(0.to_s)
    @lastResult = ""
    @lastErrNum = 0
    @lastErrDes = ""

  end
  
  # This could be re-written as
  # 
  # def hexToNum(strInput)
  #   strInput.hex
  # end
  # 
  # But I did this for the sake of getting
  # used to the language

  def hexToNum(strInput)
  
    intSixteens = 0
    intOnes = 0
    
    strInput.upcase!
    
    case strInput[0,1]
      
      when "A"
        intSixteens = 10
      when "B"
        intSixteens = 11
      when "C"
        intSixteens = 12
      when "D"
        intSixteens = 13
      when "E"
        intSixteens = 14
      when "F"
        intSixteens = 15
      else
        intSixteens = strInput[0,1].to_i
        
    end
    
    case strInput[1,1]
      
      when "A"
        intOnes = 10
      when "B"
        intOnes = 11
      when "C"
        intOnes = 12
      when "D"
        intOnes = 13
      when "E"
        intOnes = 14
      when "F"
        intOnes = 15
      else
        intOnes = strInput[1,1].to_i
        
    end
    
    intSixteens * 16 + intOnes
    
  end

  def numToHex(intNum)
  
    intSixteens = intNum / 16
    intSixteens = intSixteens.to_i;
    intOnes = intNum - (16 * intSixteens)
    
    case intOnes
      when 10
        strOnes = "A"
      when 11
        strOnes = "B"
      when 12
        strOnes = "C"
      when 13
        strOnes = "D"
      when 14
        strOnes = "E"
      when 15
        strOnes = "F"
      else
        strOnes = intOnes.to_s
    end
    
    case intSixteens
      when 10
        strSixteens = "A"
      when 11
        strSixteens = "B"
      when 12
        strSixteens = "C"
      when 13
        strSixteens = "D"
      when 14
        strSixteens = "E"
      when 15
        strSixteens = "F"
      else
        strSixteens = intSixteens.to_s
    end
    
    strSixteens + strOnes
    
  end
  
  def cByte(strInput)
    
    [strInput].pack('C')
    
  end

  def stdround(dblValue, dblMult)

    if (dblValue < 0)

      intSign = -1

    else

      intSign = 1

    end

    dblValue = dblValue.abs
    dblResult = dblValue * dblMult
    dblResult = dblResult + 0.5
    dblResult = dblResult.floor
    dblResult = dblResult / dblMult
    dblResult = dblValue * intSign

    return dblResult

  end
  
  def reCenter(mdblCenterY, mdblCenterX)
  
    @dblCenterY = mdblCenterY
    @dblCenterX = mdblCenterX
  
  end
  
  def generate(dblRadius, dblTheta)
  
    mdblTheta = BigDecimal(dblTheta.to_s)
    dblResultX = BigDecimal(0.to_s)
    dblResultY = BigDecimal(0.to_s)
    dblResultX = stdround((dblRadius * stdround(cos((mdblTheta / 180) * SngPi,16),DblMultiplier)) + @dblCenterX, DblMultiplier)
    dblResultY = stdround((dblRadius * stdround(sin((mdblTheta / 180) * SngPi,16),DblMultiplier)) + @dblCenterY, DblMultiplier)

    if (dblResultX > SngMaxUpper || dblResultX < SngMaxLower)
      reCenter(@dblCenterY, 0) 
    else
      @dblCenterX = dblResultX
    end
    
    if (dblResultY > SngMaxUpper || dblResultY < SngMaxLower)
      reCenter(0,@dblCenterX) 
    else
      @dblCenterY = dblResultY
    end
  
  end
  
  def makeRandom(dblValue, lngMax)
  
    dblValue = dblValue.abs
    dblValue = (dblValue + 0.5).floor
    intRandom = (dblValue % (lngMax + 1)).to_i
    intRandom = 0 if intRandom > lngMax
    
    return intRandom
  
  end
  
  def getStrength(strPassword)
  
    strSerial = getSerial()
    
    return (strPassword.length * 8) + (strSerial.length * 8)
  
  end
  
  def getSerial()
    
    Time.now.to_i.to_s
    
  end
  
  def encryptText(strClear, strKey)
  
    strCipher = ""
    
    raiseError(ErrKeyMissing, "Key Missing") if strKey == ""
    return -1 if strKey == ""
    
    raiseError(ErrClearTextMissing, "Clear Text Missing") if strClear ==""
    return -1 if strClear == ""
    
    raiseError(ErrInvalidKeyLength, "Invalid Key Length") if strKey.length <= 1
    return -1 if strKey.length <= 1
    
    raiseError(ErrInvalidSize, "Text Has Zero Length") if strClear.length == 0
    return -1 if strClear.length == 0
    
    strTimeSerial = getSerial
    
    intTimeSerialLength = strTimeSerial.length
    
    strTimeSerialLength = numToHex(intTimeSerialLength ^ strKey[0])
    
    arbyClear = Array.new(strClear.length)
    arbyKey = Array.new(strKey.length)
    arbyTimeSerial = Array.new(strTimeSerial.length)
    
    strClear.length.times do |i|
    
      arbyClear[i + 1] = strClear[i]

    end
    
    strKey.length.times do |i|
    
      arbyKey[i + 1] = strKey[i]
      
    end
    
    strTimeSerial.length.times do |i|
    
      arbyTimeSerial[i + 1] = strTimeSerial[i]
      
    end
    
    intPosition = 2
    
    1.upto((strKey.length / 2).to_i) do |k|
    
      strCipher += numToHex(arbyKey[k] ^ arbyKey[(strKey.length - k) + 1])
    
    end
    
    strCipher += strTimeSerialLength
    
    1.upto(strTimeSerial.length) do |i|
    
      strCipher += numToHex(arbyKey[intPosition].to_i ^ arbyTimeSerial[i].to_i)
      
      if (intPosition == strKey.length) 
      
        intPosition = 1;
        
      else
      
        intPosition += 1
      
      end
    
    end
    
    intPosition = 1
    
    intSerialPosition = 1
    
    reCenter(arbyKey[intPosition],arbyTimeSerial[intSerialPosition])
    
    intPosition += 1
    
    intSerialPosition += 1
    
    blnSecondValue = -1
    
    1.upto(strClear.length) do |i|
    
      if blnSecondValue == -1
      
        generate(arbyKey[intPosition], arbyTimeSerial[intSerialPosition])
      
	if intPosition == strKey.length
      
       	  intPosition = 1
        
      	else
      
       	  intPosition += 1
        
      	end
      
      	if intSerialPosition == strTimeSerial.length
      
          intSerialPosition = 1
        
      	else
      
          intSerialPosition += 1
        
        end
        
        strCipher += numToHex(arbyClear[i] ^ makeRandom(@dblCenterX, 255))
        
        blnSecondValue = 1
      
      else

        strCipher += numToHex(arbyClear[i] ^ makeRandom(@dblCenterY, 255))
        
        blnSecondValue = -1
      
      end
    
    end
    
    @lastResult = strCipher
    
    return 1
    
  end
  
  def decryptText(strCipher, strKey)
  
    raiseError(errCipherTextMissing,"Cipher Text Missing") if strCipher == ""
    return -1 if strCipher == ""
    
    raiseError(errInvalidSize, "Bad Text Length") if strCipher.length < 10
    return -1 if strCipher.length < 10
    
    raiseError(errKeyMissing,"Key Missing") if strKey == ""
    return -1 if strKey == ""
    
    raiseError(errInvalidKeyLength, "Invalid Key Length") if strKey.length <= 1
    return -1 if strKey.length <= 1
    
    arbyKey = Array.new(strKey.length)
    
    strTimeSerial = ""
    
    strCheckHash = ""
    
    strClear = ""
    
    strKey.length.times do |i|
    
      arbyKey[i + 1] = strKey[i]
    
    end
    
    1.upto((strKey.length / 2).to_i) do |k|
    
      strCheckHash += numToHex(arbyKey[k] ^ arbyKey[(strKey.length - k) + 1])
      
    end
    
    unless strCheckHash == strCipher[0, strCheckHash.length]
    
      raiseError(errInvalidKey,"Invalid Key")
      return -1
    
    end
  
    strCipher = strCipher[strCheckHash.length, strCipher.length - strCheckHash.length]
    
    intTimeSerialLength = arbyKey[1] ^ hexToNum(strCipher[0, 2])
    
    strCipher = strCipher[2, strCipher.length - 2]
    
    intPosition = 2
    
    arbyTimeSerial = Array.new(intTimeSerialLength)
    
    1.upto(intTimeSerialLength) do |i|
      
      arbyTimeSerial[i] = (arbyKey[intPosition].to_i ^ hexToNum(strCipher[0, 2]))
      
      strCipher = strCipher[2, strCipher.length - 2]
      
      if intPosition == strKey.length
      
        intPosition = 1
        
      else
      
        intPosition += 1
        
      end
    
    end
    
    intPosition = 1
    
    intSerialPosition = 1
    
    reCenter(arbyKey[intPosition],arbyTimeSerial[intSerialPosition])
    
    intPosition += 1
    
    intSerialPosition += 1
    
    blnSecondValue = -1
    
    intCipherTextLength = strCipher.length / 2
    
    arbyCipher = Array.new(intCipherTextLength)
    
    1.upto(intCipherTextLength) do |i|
    
      arbyCipher[i] = hexToNum(strCipher[0, 2])
      
      strCipher = strCipher[2, strCipher.length - 2]
    
    end

    1.upto(intCipherTextLength) do |i|
    
      if blnSecondValue == -1
      
        generate(arbyKey[intPosition], arbyTimeSerial[intSerialPosition])

      	if intPosition == strKey.length
      
          intPosition = 1
        
      	else
      
          intPosition += 1
      
      	end
      
      	if intSerialPosition == intTimeSerialLength
      
          intSerialPosition = 1
        
      	else
      
          intSerialPosition += 1
        
      	end

        strClear << (arbyCipher[i].to_i ^ makeRandom(@dblCenterX, 255))
        
        blnSecondValue = 1
        
      else
      
        strClear << (arbyCipher[i].to_i ^ makeRandom(@dblCenterY, 255))
        
        blnSecondValue = -1
      
      end
    
    end
    
    @lastResult = strClear
    
    return 1;
  
  end
  
  def raiseError(intErrNum, strErrDes)
  
    @lastErrNum = intErrNum;
    @lastErrDes = strErrDes;
  
  end
  
  def encryptFile(strInputFile, strKey, strOutputFile)
    
    raiseError(ErrInputFileMissing, "Input File Missing") if strInputFile == ""
    return -1 if strInputFile == ""
    
    raiseError(ErrOutputFileMissing, "Output File Missing") if strOutputFile == ""
    return -1 if strOutputFile == ""
    
    raiseError(ErrSameFile, "Output File Cannot Be Input File") if strOutputFile == strInputFile
    return -1 if strOutputFile == strInputFile
    
    raiseError(ErrKeyMissing, "Key Missing") if strKey ==""
    return -1 if strKey == ""
    
    raiseError(ErrInvalidKeyLength, "Invalid Key Length") if strKey.length <= 1
    return -1 if strKey.length <= 1
    
    strTimeSerial = getSerial
    
    arbyKey = Array.new(strKey.length)
    arbyTimeSerial = Array.new(strTimeSerial.length)
    
    strKey.length.times do |i|
    
      arbyKey[i + 1] = strKey[i]
      
    end
    
    strTimeSerial.length.times do |i|
    
      arbyTimeSerial[i + 1] = strTimeSerial[i]
      
    end
    
    fInput = File.new(strInputFile, "rb")
    fOutput = File.new(strOutputFile, "wb")
    
    raiseError(ErrEmptyFile, "File Has Zero Length") if fInput.stat.size == 0
    return -1 if fInput.stat.size == 0
    
    dblFileSize = fInput.stat.size
    
    dblFileLeft = fInput.stat.size
    
    1.upto((strKey.length / 2).to_i) do |k|
    
      fOutput.write(cByte(arbyKey[k] ^ arbyKey[(strKey.length - k) + 1]))
    
    end
    
    intPosition = 1
    intSerialPosition = 1
    
    fOutput.write(cByte(strTimeSerial.length ^ arbyKey[intPosition]))
    
    intPosition += 1
    
    1.upto(strTimeSerial.length) do |i|
    
      fOutput.write cByte(arbyKey[intPosition].to_i ^ arbyTimeSerial[i].to_i)
      
      if (intPosition == strKey.length) 
      
        intPosition = 1;
        
      else
      
        intPosition += 1
      
      end
    
    end    
    
    intPosition = 1
    intSerialPosition = 1
    
    reCenter(arbyKey[intPosition],arbyTimeSerial[intSerialPosition])
    
    intPosition += 1
    
    intSerialPosition += 1
    
    blnSecondValue = -1

    while dblFileLeft > 0
      
      if dblFileLeft < IntBlockSize
          
          dblActualSize = dblFileLeft
          
          dblFileLeft = dblFileLeft - dblFileLeft
          
      else
          
          dblActualSize = IntBlockSize
          
          dblFileLeft = dblFileLeft - IntBlockSize
          
      end
      
      strCipher = ""
      strClear = ""
      strClear = fInput.read(dblActualSize)
      
      1.upto(strClear.length) do |i|
        
        if blnSecondValue == -1
          
          generate(arbyKey[intPosition], arbyTimeSerial[intSerialPosition])

          if intPosition == strKey.length
          
            intPosition = 1
          
          else
          
            intPosition += 1
          
          end
          
          if intSerialPosition == strTimeSerial.length
          
            intSerialPosition = 1
          
          else
          
            intSerialPosition += 1
          
          end
          
          strCipher += cByte(strClear[i - 1] ^ makeRandom(@dblCenterX, 255))
          
          blnSecondValue = 1
          
        else
          
          strCipher += cByte(strClear[i - 1] ^ makeRandom(@dblCenterY, 255))
          
          blnSecondValue = -1
          
        end
          
      end
      
      fOutput.write strCipher
      
    end
    
    fOutput.close
    fInput.close
    
    return 1
    
  end
  
  def decryptFile(strInputFile, strKey, strOutputFile)
    
    raiseError(ErrInputFileMissing, "Input File Missing") if strInputFile == ""
    return -1 if strInputFile == ""
    
    raiseError(ErrOutputFileMissing, "Output File Missing") if strOutputFile == ""
    return -1 if strOutputFile == ""
    
    raiseError(ErrSameFile, "Output File Cannot Be Input File") if strOutputFile == strInputFile
    return -1 if strOutputFile == strInputFile
    
    raiseError(ErrKeyMissing, "Key Missing") if strKey ==""
    return -1 if strKey == ""
    
    raiseError(ErrInvalidKeyLength, "Invalid Key Length") if strKey.length <= 1
    return -1 if strKey.length <= 1
    
    arbyKey = Array.new(strKey.length)
    
    strKey.length.times do |i|
      
      arbyKey[i + 1] = strKey[i]
      
    end
    
    fInput = File.new(strInputFile, "rb")
    fOutput = File.new(strOutputFile, "wb")
    
    raiseError(ErrEmptyFile, "File Has Zero Length") if fInput.stat.size == 0
    return -1 if fInput.stat.size == 0
    
    raiseError(ErrInvalidFileSize, "File Has Invalid Size") if fInput.stat.size < 10
    return -1 if fInput.stat.size < 10
    
    dblFileSize = fInput.stat.size
    dblFileLeft = fInput.stat.size
    
    strCheckHash = ""
    strKeyHash = ""
    
    1.upto((strKey.length / 2).to_i) do |k|
      
      strCheckHash << (arbyKey[k] ^ arbyKey[(strKey.length - k) + 1])
      
    end
    
    strKeyHash = fInput.read(strCheckHash.length)
    
    raiseError(ErrInvalidKey, "Invalid Key") unless strCheckHash == strKeyHash
    fInput.close unless strCheckHash == strKeyHash
    fOutput.close unless strCheckHash == strKeyHash
    return -1 unless strCheckHash == strKeyHash
    
    intPosition = 1
    intSerialPosition = 1
    intCipherTimeSerialLength = fInput.read(1)[0]
    
    intTimeSerialLength = (intCipherTimeSerialLength ^ arbyKey[intPosition])
    
    intPosition += 1
    
    strCipherTimeSerial = fInput.read(intTimeSerialLength)
    
    arbyTimeSerial = Array.new(intTimeSerialLength)
    
    strCipherTimeSerial.length.times do |i|
      
      arbyTimeSerial[i + 1] = strCipherTimeSerial[i]
      
    end
    
    strTimeSerial = ""
    
    1.upto(intTimeSerialLength) do |i|
    
      strTimeSerial << (arbyKey[intPosition].to_i ^ arbyTimeSerial[i].to_i)
      
      if (intPosition == strKey.length) 
      
        intPosition = 1;
        
      else
      
        intPosition += 1
      
      end
    
    end    
    
    arbyTimeSerial = Array.new(intTimeSerialLength)
    
    strTimeSerial.length.times do |i|
      
      arbyTimeSerial[i + 1] = strTimeSerial[i]
      
    end
    
    intPosition = 1
    intSerialPosition = 1
    
    reCenter(arbyKey[intPosition],arbyTimeSerial[intSerialPosition])
    
    intPosition += 1
    
    intSerialPosition += 1
    
    blnSecondValue = -1
    
    while dblFileLeft > 0
      
      if dblFileLeft < IntBlockSize
          
          dblActualSize = dblFileLeft
          
          dblFileLeft = dblFileLeft - dblFileLeft
          
      else
          
          dblActualSize = IntBlockSize
          
          dblFileLeft = dblFileLeft - IntBlockSize
          
      end
      
      strCipher = ""
      strClear = ""
      strCipher = fInput.read(dblActualSize)
      
      1.upto(strCipher.length) do |i|
        
        if blnSecondValue == -1
          
          generate(arbyKey[intPosition], arbyTimeSerial[intSerialPosition])

          if intPosition == strKey.length
          
            intPosition = 1
          
          else
          
            intPosition += 1
          
          end
          
          if intSerialPosition == strTimeSerial.length
          
            intSerialPosition = 1
          
          else
          
            intSerialPosition += 1
          
          end
           
          strClear += cByte(strCipher[i - 1] ^ makeRandom(@dblCenterX, 255))
          
          blnSecondValue = 1
          
        else
          
          strClear += cByte(strCipher[i - 1] ^ makeRandom(@dblCenterY, 255))
          
          blnSecondValue = -1
          
        end
          
      end
      
      fOutput.write strClear
      
    end
    
    fOutput.close
    fInput.close
    
    return 1

  end
  
end