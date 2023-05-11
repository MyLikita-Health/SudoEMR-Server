const request = require('request');
const accountSid = '';
const authToken = '';
const client = require('twilio')(accountSid, authToken);


exports.sendSMS = (phone, message, callback=f=>f, err=f=>f) => {

	var options = {
	  'method': 'POST',
	  'url': `${process.env.SMS_API_URL}/create?api_token=${process.env.SMS_API_KEY}&to=${phone}&from=[SudoEMR]&body=${message}&dnd=2`,
	};

	request(options, function (error, response) {
	  if (error) err(error);
	  callback(response.body);
	});

}