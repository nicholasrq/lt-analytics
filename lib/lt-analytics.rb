require "split/helper"

module Split
	module LTAnalytics

		# main helper
		def tracking_code(options={}, top = true)
			account = top ? options[:account] : nil
			raise "Account code MUST be specified" if top && account.nil?

			# if it's a environment-specific call
			return if options[:rails_env].present? && !environment_test(options[:rails_env])

			# if using partial
			unless (partial = options[:partial]).nil?

				render(:partial => partial, :locals => {
					:account 		=> account,
					:custom_vars 	=> raw(custom_variables)
				})

			else
				code = <<-EOF
					<script type="text/javascript">
						var _gaq = _gaq || [];
						_gaq.push(['_setAccount', '#{account}']);
						#{custom_variables}
						_gaq.push(['_trackPageview']);
						_gaq.push(['_trackPageLoadTime']);

						(function() {
							var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
							ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
							var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
						})();
					</script>
				EOF
				code = raw(code)if defined?(raw)
				code
			end
		end

		def custom_variables
			return nil if session[:split].nil?
			arr = []
			session[:split].each_with_index do |h,i|
				arr << "_gaq.push(['_setCustomVar', #{i+1}, '#{h[0]}', '#{h[1].mb_chars.truncate(128-h[0].length, omission:'')}', 1]);"
			end
			arr.reverse[0..4].reverse.join("\n")
		end

		def environment_test(env)
			current_environment = Rails.env.to_sym
			case env.class.to_s.downcase
				when "array"
					env_map = env.map {|item| item.to_sym}
					return env_map.include?(current_environment)
				when "symbol"
					return current_environment == env
				when "string"
					return current_environment.to_s.downcase == env
				else true
			end
		end

	end
end

module Split::Helper
	include Split::LTAnalytics
end

if defined?(Rails)
	class ActionController::Base
		ActionController::Base.send :include, Split::LTAnalytics
		ActionController::Base.helper Split::LTAnalytics
	end
end
