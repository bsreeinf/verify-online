module StudentVerificationHelper

	def verifyChecksum( merchantID,  orderID,  amount,  authDesc,  workingKey,  checksum) 

		String str = merchantID+“|”+orderID+“|”+amount+“|”+authDesc+“|”+workingKey

		String newChecksum = Zlib::adler32(str).to_s

		return (newChecksum.eql?(checksum)) ? true : false

	end

	def getChecksum( merchantID,  orderID,  amount,  redirectUrl,  workingKey) 

		String str = merchantID + “|” + orderID + “|” + amount + “|” + redirectUrl + “|” + workingKey;

		return Zlib::adler32(str)

	end

	def encrypt_string(ccaRequest)
		Dir.chdir("#{RAILS_ROOT}/public/jars/") do

	      encRequest = %x[java -jar ccavutil.jar #{CCAVENUE_WORKING_KEY} "#{ccaRequest}" enc]

	    end
	    return encRequest
	end
	
	def decrypt_string(encRequest)
		Dir.chdir("#{RAILS_ROOT}/public/jars/") do

       		ccaResponse = %x[java -jar ravi-ccavutil.jar #{CCAVENUE_WORKING_KEY} "#{encResponse}" dec]

		end
	    return ccaResponse
	end


end
