library flutter_termii;

import 'dart:convert';

import 'network_helper.dart';

class Termii {
  /// The base URL is used to route your request to the appropriate "regulatory region" and to optimize traffic between data centers with the region.
  final String url;

  /// API calls are authenticated by including your API key in the body of the request you make.
  final String apiKey;

  /// A Sender ID is the name or number that identifies the sender of an SMS message.
  final String senderId;

  Termii({
    required this.url,
    required this.apiKey,
    required this.senderId,
  });

  /// Send text messages across different messaging channels.
  Future<dynamic> sendSms({
    /// Represents the destination phone number. Phone number must be in the international format (Example: 23490126727).
    required String destination,

    /// Text of a message that would be sent to the destination phone number.
    required String message,

    /// This is the route through which the message is sent. It is either dnd, whatsapp, or generic.
    String channel = 'generic',
  }) async {
    final response = await NetworkHelper.postRequest(
      url: "$url/api/sms/send",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'to': destination,
        'from': senderId,
        'sms': message,
        'type': 'plain',
        'channel': channel,
        'api_key': apiKey,
      }),
    );
    return response.body;
  }

  /// Send media messages across different messaging channels.
  Future<dynamic> sendMediaSms({
    /// Represents the destination phone number. Phone number must be in the international format (Example: 23490126727).
    required String destination,

    /// The url to the file resource.
    required String mediaUrl,

    /// This is the route through which the message is sent. It is either dnd, whatsapp, or generic.
    String channel = 'generic',

    /// The caption that should be added to the image,
    String? mediaCaption,
  }) async {
    final response = await NetworkHelper.postRequest(
      url: "$url/api/sms/send",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'to': destination,
        'from': senderId,
        'type': 'plain',
        'channel': channel,
        'api_key': apiKey,
        'media': {
          'url': mediaUrl,
          'caption': mediaCaption,
        }
      }),
    );
    return response.body;
  }

  /// Send bulk text messages across different messaging channels to multiple phone numbers.
  Future<dynamic> sendBulkSms({
    /// Represents the array of phone numbers you are sending to (Example: ["23490555546", "23423490126999","23490555546"]).
    required List<String> multipleDestinations,

    /// Text of a message that would be sent to the destination phone number.
    required String message,
    String channel = 'generic',
  }) async {
    final response = await NetworkHelper.postRequest(
      url: "$url/api/sms/send/bulk",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'to': multipleDestinations,
        'from': senderId,
        'sms': message,
        'type': 'plain',
        'channel': channel,
        'api_key': apiKey,
      }),
    );
    return response.body;
  }

  /// Send messages with auto-generated messaging numbers that adapt to customers location.
  Future<dynamic> sendSmsWithAutoGeneratedNumber({
    required String destination,
    required String message,
  }) async {
    final response = await NetworkHelper.postRequest(
      url: "$url/api/sms/number/send",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'to': destination,
        'sms': message,
        'api_key': apiKey,
      }),
    );
    return response.body;
  }

  /// The send token triggers one-time-passwords (OTP) across any available messaging channel.
  Future<dynamic> sendToken({
    /// The destination phone number. Phone number must be in the international format (Example: 23490126727).
    required String destination,

    /// Type of message that will be generated and sent as part of the OTP message. You can set message type to numeric or alphanumeric.
    required MessageType messageType,
    String channel = 'generic',
    required int pinAttempts,

    /// Represents how long the PIN is valid before expiration. The time is in minutes. The minimum time value is 0 and the maximum time value is 60.
    required int pinExpiryTime,

    /// The length of the PIN code.It has a minimum of 4 and maximum of 8.
    required int pinLength,

    /// Example: "< 1234 >".
    ///
    /// PIN placeholder. Right before sending the message, PIN code placeholder will be replaced with generate PIN code.
    required String pinPlaceholder,

    /// Text of a message that would be sent to the destination phone number.
    required String messageText,

    /// Type of PIN code that will be generated and sent as part of the OTP message. It has a minimum of one attempt.
    required MessageType pinType,
  }) async {
    final response = await NetworkHelper.postRequest(
      url: "$url/api/sms/otp/send",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': apiKey,
        'message_type':
            messageType == MessageType.numeric ? 'NUMERIC' : 'ALPHANUMERIC',
        'to': destination,
        'from': senderId,
        'channel': channel,
        'pin_attempts': pinAttempts,
        'pin_time_to_live': pinExpiryTime,
        'pin_length': pinLength,
        'pin_placeholder': pinPlaceholder,
        'message_text': messageText,
        'pin_type': pinType == MessageType.numeric ? 'NUMERIC' : 'ALPHANUMERIC',
      }),
    );
    return response.body;
  }

  /// Trigger one-time passwords (OTP) through the voice channel to a phone number.
  Future<dynamic> sendVoiceToken({
    required String destination,
    required int pinAttempts,
    required int pinExpiryTime,
    required int pinLength,
  }) async {
    final response = await NetworkHelper.postRequest(
      url: "$url/api/sms/otp/send/voice",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': apiKey,
        'phone_number': destination,
        'pin_attempts': pinAttempts,
        'pin_time_to_live': pinExpiryTime,
        'pin_length': pinLength,
      }),
    );
    return response.body;
  }

  /// Send messages from your application through our voice channel to a phone number.
  Future<dynamic> sendVoiceCall({
    required String destination,
    required int code,
  }) async {
    final response = await NetworkHelper.postRequest(
      url: "$url/api/sms/otp/call",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': apiKey,
        'phone_number': destination,
        'code': code,
      }),
    );
    return response.body;
  }

  /// This API returns OTP codes in JSON format which can be used within any web or mobile app.
  Future<dynamic> generateInAppToken({
    required String destination,
    required int pinAttempts,
    required int pinExpiryTime,
    required int pinLength,
    required MessageType pinType,
  }) async {
    final response = await NetworkHelper.postRequest(
      url: "$url/api/sms/otp/generate",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': apiKey,
        'phone_number': destination,
        'pin_attempts': pinAttempts,
        'pin_time_to_live': pinExpiryTime,
        'pin_length': pinLength,
        'pin_type': pinType == MessageType.numeric ? 'NUMERIC' : 'ALPHANUMERIC',
      }),
    );
    return response.body;
  }

  /// Verify token API, checks tokens sent to customers and returns a response confirming the status of the token.
  Future<dynamic> verifyToken({
    required String pinId,
    required String pin,
  }) async {
    final response = await NetworkHelper.postRequest(
      url: "$url/api/sms/otp/verify",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'api_key': apiKey,
        'pin_id': pinId,
        'pin': pin,
      }),
    );
    return response.body;
  }

  /// The Balance API returns your total balance and balance information from your wallet, such as currency.
  Future<dynamic> veiwBalance({
    required String pinId,
    required String pin,
  }) async {
    final response = await NetworkHelper.getRequest(
      url: "$url/api/get-balance?api_key=$apiKey",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  /// The search API allows businesses verify phone numbers and automatically detect their status as well as current network.
  Future<dynamic> searchPhoneNumber({
    required String phoneNumber,
  }) async {
    final response = await NetworkHelper.getRequest(
      url: "$url/api/check/dnd?api_key=$apiKey&phone_number=$phoneNumber",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  /// The status API allows businesses to detect if a number is fake or has ported to a new network.
  Future<dynamic> detectPhoneNumberStatus({
    required String phoneNumber,
    required String countryCode,
  }) async {
    final response = await NetworkHelper.getRequest(
      url:
          "$url/api/insight/number/query?phone_number=$phoneNumber&api_key=$apiKey&country_code=$countryCode",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }
}

enum MessageType { numeric, alphanumeric }