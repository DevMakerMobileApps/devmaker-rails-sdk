module Mutations::Mixins::ErrorHandlingMutation
  def destroy_and_handle_errors_of(what, record)
    if record.destroy
      {what => record}
    else
      {errors: record.errors.full_messages}
    end
  end

  def save_and_handle_errors_of(what, record)
    if record.save
      {what => record}
    else
      {errors: record.errors.full_messages}
    end
  end

  def not_found_error(what, id)
    {errors: ["'#{what}' not found with ID: #{id}"]}
  end
end
