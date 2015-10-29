module ForemanTags
	module HostsControllerExtensions
		extend ActiveSupport::Concern

		def tag
			@host = Host::Base.find(params['id'])
			render '_tag'
		end

		def add_tag
			@host = Host::Base.find(params['id'])
			@host.when_list.add(Time.now.to_formatted_s(:short))
			@host.who_list.add(User.current)
			@host.type_list.add(params['tag_status'])
			@host.reason_list.add(params['tag_reason'])
			@host.save(:validate => false)
			redirect_to :back
		end

		def remove_tag
			@host = Host::Base.find(params['id'])
			@host.when_list = ""
			@host.who_list = ""
			@host.type_list = ""
			@host.reason_list = ""
			@host.save
			redirect_to :back
		end

		def action_permission
			case params[:action]
				when 'clone', 'externalNodes', 'overview', 'bmc', 'vm', 'runtime', 'resources', 'templates', 'nics',
						'pxe_config', 'storeconfig_klasses', 'active', 'errors', 'out_of_sync', 'pending', 'disabled', 'tag'
					:view
				when 'puppetrun', 'multiple_puppetrun', 'update_multiple_puppetrun'
					:puppetrun
				when 'setBuild', 'cancelBuild', 'multiple_build', 'submit_multiple_build', 'review_before_build',
						'rebuild_config', 'submit_rebuild_config'
					:build
				when 'power'
					:power
				when 'ipmi_boot'
					:ipmi_boot
				when 'console'
					:console
				when 'toggle_manage', 'multiple_parameters', 'update_multiple_parameters',
						'select_multiple_hostgroup', 'update_multiple_hostgroup', 'select_multiple_environment',
						'update_multiple_environment', 'multiple_disable', 'submit_multiple_disable',
						'multiple_enable', 'submit_multiple_enable',
						'update_multiple_organization', 'select_multiple_organization',
						'update_multiple_location', 'select_multiple_location',
						'disassociate', 'update_multiple_disassociate', 'multiple_disassociate','add_tag', 'remove_tag'
					:edit
				when 'multiple_destroy', 'submit_multiple_destroy'
					:destroy
				else
					super
			end
		end
	end
end