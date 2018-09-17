# frozen_string_literal: true

module Zoom
  class Defaults
    ACCOUNT_OPTIONS_PAY_MODES = { 'Master account holder pays' => 'master', # default
                                  'Sub account holder pays' => 'sub'
                                }.freeze

    IM_GROUP_TYPES = { 'Only members can see the group automatically. Other people can search members in the group.' => 'normal', # default
                       'All people in the account can see the group and members automatically' => 'shared',
                       'Nobody can see the group or search members except the members in the group' => 'restricted'
                      }.freeze

    RECURRENCE_TYPES = { 'Daily' => 1,
                         'Weekly' => 2,
                         'Monthly' => 3
                        }.freeze # no default

    RECURRENCE_WEEKLY_DAYS = { 'Sunday' => 1,
                              'Monday' => 2,
                              'Tuesday' => 3,
                              'Wednesday' => 4,
                              'Thursday' => 5,
                              'Friday' => 6,
                              'Saturday' => 7
                            }.freeze # no default

    RECURRENCE_MONTHLY_WEEKS = { 'Last week' => -1,
                                 'First week' => 1,
                                 'Second week' => 2,
                                 'Third week' => 3,
                                 'Fourth week' => 4
                                }.freeze # no default

    MEETING_TYPES = { 'Instant Meeting' => 1,
                      'Scheduled Meeting' => 2, # default
                      'Recurring Meeting with no fixed time' => 3,
                      'Recurring Meeting with fixed time' => 8
                    }.freeze

    MEETING_APPROVAL_TYPES = { 'Automatically Approve' => 0,
                               'Manually Approve' => 1,
                               'No Registration Required' => 2 # default
                              }.freeze

    MEETING_REGISTRATION_TYPES = { 'Attendees register once and can attend any of the occurrences' => 1, # default
                                   'Attendees need to register for each occurrence to attend' => 2,
                                   'Attendees register once and can choose one or more occurrences to attend' => 3
                                  }.freeze

    MEETING_AUDIO_TYPE = { 'Both Telephony and VoIP' => 'both', # default
                           'Telephony only' => 'telephony',
                           'VoIP only' => 'voip'
                          }.freeze

    MEETING_AUTO_RECORDING = { 'Record to local device' => 'local',
                               'Record to cloud' => 'cloud',
                               'No Recording' => 'none' # default
                              }.freeze

    REGISTRANT_STATUS_ACTIONS = { 'Approve registrant' => 'approve',
                                  'Cancel registrant' => 'cancel',
                                  'Deny registrant' => 'deny'
                                }.freeze # no default

    WEBINAR_TYPES = { 'Webinar' => 5, # default
                      'Recurring Webinar with no fixed time' => 6,
                      'Recurring Webinar with fixed time' => 9
                    }.freeze

    WEBINAR_APPROVAL_TYPES = { 'Automatically Approve' => 0,
                               'Manually Approve' => 1,
                               'No Registration Required' => 2 # default
                              }.freeze

    WEBINAR_REGISTRATION_TYPES = { 'Attendees register once and can attend any of the occurrences' => 1, # default
                                   'Attendees need to register for each occurrence to attend' => 2,
                                   'Attendees register once and can choose one or more occurrences to attend' => 3
                                  }.freeze

    WEBINAR_AUDIO_TYPE = { 'Both Telephony and VoIP' => 'both', # default
                           'Telephony only' => 'telephony',
                           'VoIP only' => 'voip'
                          }.freeze

    WEBINAR_AUTO_RECORDING = { 'Record to local device' => 'local',
                               'Record to cloud' => 'cloud',
                               'No Recording' => 'none' # default
                              }.freeze

    USER_TYPES = { 'basic' => 1,
                   'pro' => 2,
                   'corp' => 3
                  }.freeze # no default
  end
end
