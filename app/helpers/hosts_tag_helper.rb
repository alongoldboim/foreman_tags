module HostsTagHelper
    def tag_tool_tip(host)
      "At:  #{host.when_list[0]} <br>
      Added by:  #{host.who_list[0]} <br>
      Reason:  #{host.reason_list[0]}"
   end
end
