class RailsGraphqlNplus1Schema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Relay-style Object Identification:

  # Return a string UUID for `object`
  def self.id_from_object(object, type_definition, query_ctx)
    GraphQL::Schema::UniqueWithinType.encode(type_definition.name, object.id)
  end

  # Given a string UUID, find the object
  def self.object_from_id(id, query_ctx)
    type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
    type_class = types[type_name]

    return nil if type_class.nil?

    unless type_class.metadata[:type_class] < Types::BaseRelayObject
      raise "Attempted to load non-relay object #{type_name} #{item_id}"
    end

    type_class.metadata[:type_class].from_id(item_id, query_ctx)
  rescue ActiveRecord::RecordNotFound, ArgumentError
    nil
  end
end
