const request = require('request');
const accountSid = '';
const authToken = '';
const client = require('twilio')(accountSid, authToken);


// exports.sendSMS = (recipient, content) => {
//   client.messages
//     .create({
//       from: '+15202540652',
//       to: recipient,
//       body: content,
//     })
//     .then((message) => console.log(message.sid))
//     .done();
// };

const smsAPIKey = ''

const smsAPIurl = '';

exports.sendSMS = (phone, message, callback=f=>f, err=f=>f) => {

	var options = {
	  'method': 'POST',
	  'url': `${smsAPIurl}/create?api_token=${smsAPIKey}&to=${phone}&from=[MyLikita]&body=${message}&dnd=2`,
	};

	request(options, function (error, response) {
	  if (error) err(error);
	  callback(response.body);
	});

}