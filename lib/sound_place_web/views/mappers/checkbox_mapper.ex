defmodule SoundPlaceWeb.Mappers.CheckboxMapper do
  use PhoenixMTM.Mappers

  def bootstrap(form, field, input_opts, label_content, label_opts, _opts) do
    content_tag(:div, class: "form-group checkbox") do
      label(form, field, label_opts) do
        [
          tag(:input, input_opts),
          html_escape("  #{label_content}")
        ]
      end
    end
  end
end
