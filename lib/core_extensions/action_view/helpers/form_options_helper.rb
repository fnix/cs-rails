module ActionView
  module Helpers
    module FormOptionsHelper
      # Generate select and country option tags for the given object and method. A
      # common use of this would be to allow users to select a state subregion within
      # a given country.
      #
      # object       - The model object to generate the select for
      # method       - The attribute on the object
      # options      - Other options pertaining to option tag generation. See
      #                `region_options_for_select`.
      # html_options - Options to use when generating the select tag- class,
      #                id, etc.
      #
      # Uses country_options_for_select to generate the list of option tags.
      #
      # Example:
      #
      #   country_select(@object, :country, {priority: ['US', 'CA']}, class: 'country')
      #
      # Note that in order to preserve compatibility with various existing
      # libraries, an alternative API is supported but not recommended:
      #
      #   country_select(@object, :region, ['US', 'CA'], class: region)
      #
      # Returns an `html_safe` string containing the HTML for a select element.
      def country_select(object, method, priority_or_options = {}, options = {}, html_options = {})
        if Hash === priority_or_options
          html_options = options
          options = priority_or_options
        else
          options[:priority] = priority_or_options
        end
        select_tag = ActionView::Helpers::Tags::Base.new(object, method, self, options)
        select_tag.to_country_select_tag(ISO3166::Country.all, options, html_options)
      end

      def country_options_for_select(countries, selected = nil, options = {})
        language = I18n.locale.to_s.sub(/-.*/, '')
        country_options = ''
        priority_countries_codes = options[:priority] || []
        
        unless priority_countries_codes.empty?
          countries = ISO3166::Country.all unless countries.empty?
          priority_countries = priority_countries_codes.map do |code|
            country = ISO3166::Country[code]
            [country.translation(language) || country.name, country.alpha2] if country
          end.compact
          unless priority_countries.empty?
            country_options += options_for_select(priority_countries, selected)
            country_options += "<option disabled>-------------</option>"

            selected = nil if priority_countries_codes.include?(selected)
          end
        end

        collator = ICU::Collation::Collator.new(I18n.locale.to_s)
        main_options = countries.map { |c| [c.translation(language) || c.name, c.alpha2] }
        main_options.sort! { |a, b| collator.compare(a.first, b.first) }
        main_options.unshift [options['prompt'], ''] if options['prompt']

        country_options += options_for_select(main_options, selected)
        country_options.html_safe
      end
    end

    module Tags
      class Base
        def to_country_select_tag(countries, options = {}, html_options = {})
          html_options = html_options.stringify_keys
          add_default_name_and_id(html_options)
          options[:include_blank] ||= true unless options[:prompt] || select_not_required?(html_options)

          value = options[:selected] ? options[:selected] : value(object)
          priority_regions = options[:priority] || []
          opts = add_options(country_options_for_select(countries, value, :priority => priority_regions), options, value)
          select = content_tag("select", opts, html_options)
          if html_options["multiple"] && options.fetch(:include_hidden, true)
            tag("input", :disabled => html_options["disabled"], :name => html_options["name"], :type => "hidden", :value => "") + select
          else
            select
          end
        end
      end
    end

    class FormBuilder
      # Generate select and country option tags with the provided name. A
      # common use of this would be to allow users to select a country name inside a
      # web form.
      #
      # See `FormOptionsHelper::country_select` for more information.
      def country_select(method, priority_or_options = {}, options = {}, html_options = {})
        if Hash === priority_or_options
          html_options = options
          options = priority_or_options
        else
          options[:priority] = priority_or_options
        end

        @template.country_select(@object_name, method, objectify_options(options), @default_options.merge(html_options))
      end
    end
  end
end