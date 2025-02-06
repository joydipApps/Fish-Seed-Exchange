//  http_urls.dart -checked
class Urls {
  // Register User
  static const String registerUserEndPoint =
      'https://fishseed.prayasfpg.com/user_profile_details_save';
  // Save Seed Sale
  static const String seedSaleDetailsSaveEndPoint =
      'https://fishseed.prayasfpg.com/seed_sale_details_save';

  // View Seed Sale
  static const String seedSaleDetailsViewEndPoint =
      'https://fishseed.prayasfpg.com/get_seed_sale_details';

  // Update Seed Sale for view
  static const String seedSaleUpdateEndPoint =
      'https://fishseed.prayasfpg.com/get_single_seed_sale_details';

  //  seedSaleUpdateEndPoint

  // Get Media, Picture and Videos.
  static const String getMediaFilesEndPoint =
      'https://fishseed.prayasfpg.com/get_seed_pic_videos';

  // Add Media, Picture and Videos.
  static const String sendMediaFilesEndPoint =
      'https://fishseed.prayasfpg.com/seed_pic_videos_save';
  // Video Start

  // upload Video File  Streaming
  static const String sendVideoFilesEndPoint =
      'https://fishseed.prayasfpg.com/api/upload';
  // Input (form-data): user_id =>7, file => videp.mp4

  // view Video List Streaming
  static const String viewVideoListEndPoint =
      'https://fishseed.prayasfpg.com/api/thumbnail_list';
  // Input (form-data): user_phno => 9831077172

  // view Video File Streaming
  static const String viewVideoFilesEndPoint =
      'https://fishseed.prayasfpg.com/api/stream';
  // Input (form-data): video_id and user_phno

  // Video End

  // View Fish List
  static const String getFishListEndPoint =
      'https://fishseed.prayasfpg.com/get_fish_list';

  // Get Fish Category List
  static const String getFishCategoryEndPoint =
      'https://fishseed.prayasfpg.com/get_fish_category';

  // Save Location
  static const String addLocationDataEndPoint =
      'https://fishseed.prayasfpg.com/user_address_save';

  // Update Single Location
  static const String updateLocationDataEndPoint =
      'https://fishseed.prayasfpg.com/user_address_update';

// view Location
  static const String viewLocationDataEndPoint =
      'https://fishseed.prayasfpg.com/get_user_address';

// [Note: type value will be (“user_phno” or “location_id”)]
  // {"req_type": "user_phno",or "location_id"  "phone-no": "9831077172" }
// {"req_type": "user_phno", "req_value": "9831077172"}
// {"req_type": "location_id", "req_value": "4"}

  // // get multiple address for phone no
  // static const String addressListDataEndPoint =
  //     'https://fishseed.prayasfpg.com/get_user_address';

  // location update phone no
  static const String seedSaleLocationUpdateEndPoint =
      'https://fishseed.prayasfpg.com/seed_sale_location_update';

  // set default location for phone no
  static const String defaultLocationUpdateEndPoint =
      'https://fishseed.prayasfpg.com/default_location_update';

  // set default location for phone no
  static const String removeLocationDataEndPoint =
      'https://fishseed.prayasfpg.com/remove_location';

  // Add Enquiry
  static const String addEnquiryDataEndPoint =
      'https://fishseed.prayasfpg.com/enquiry_details_save';

// View Enquiry
  static const String viewEnquiryDataEndPoint =
      'https://fishseed.prayasfpg.com/get_enquiry_details';

  // Update single  Enquiry
  static const String updateEnquiryDataEndPoint =
      'https://fishseed.prayasfpg.com/get_single_enquiry_details';
  // {"enquiry_id":"16" }

  // Add leads
  static const String addLeadsDataEndPoint =
      'https://fishseed.prayasfpg.com/leads_data_save';

  // View leads
  static const String viewLeadsDataEndPoint =
      'https://fishseed.prayasfpg.com/get_leads_data';

  // get one View leads
  static const String updateLeadsDataEndPoint =
      'https://fishseed.prayasfpg.com/get_single_lead_details';
  //   Input: { "leads_id":"10" }

  // pin code
  static const String getPinCodeDataEndPoint =
      'http://www.postalpincode.in/api/pincode';
}
