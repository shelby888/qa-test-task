class BasePage < SitePrism::Page
  module AddressableRoutes
    extend ActiveSupport::Concern

    module ClassMethods
      def addressable_routes
        @addressable_routes ||= Rails.application.routes.routes
          .select { |route| route.name.present? }
          .flat_map { |route| generate_addressable_path_and_url(route) }
          .to_h
      end

      def generate_addressable_path_and_url(route)
        addressable_template = convert_to_addressable(route)
        [
          [route.name + '_path', addressable_template],
          [route.name + '_url', addressable_template]
        ]
      end

      def convert_to_addressable(route)
        result = route.path.spec.to_s.chomp("(.:format)")
        route.required_parts.each do |attribute|
          result = result.gsub(":#{attribute}", "{#{attribute}}")
        end
        result += '{?query*}'
        result
      end
    end

    def method_missing(meth, *args)
      routes = self.class.addressable_routes
      return routes[meth.to_s] if routes.keys.include? meth.to_s
      raise RouteNotFound
    end
  end

  class Routes
    include AddressableRoutes
  end

  def self.routes
    @routes ||= Routes.new
  end

  def find_section(sections, field, field_value)
    sections.find do |section|
      section.send(field).text == field_value
    end
  end
end
