# cs-rails

Sometime ago I used [carmen-rails](https://github.com/jim/carmen-rails) and liked the project, but it's not maintained anymore. I also felt that it was not very magical and some simple spells could make it more sexy!

## Instalation

```ruby
gem 'cs-rails'
```

## Usage

I only used with [Simple Form](https://github.com/plataformatec/simple_form) and didn't write any test, so no country_select_tag for now, you must have a FormBuilder to use it.

First, you have to mount cs-rails engine: `mount CsRails::Engine, at: '/cs'`

Add the country select with/without priority countries.

```ruby
= f_address.input :country, priority: ['BR', 'AR', 'CL', 'PY', 'UY'], input_html: { data: { cs_rails: true } }
```

You have to `#= require cs-rails/countries`. It will find any country input with data-cs-rails attribute and submit an ajax request to find the states for the selected country. If the states aren't find for the country, the state select is replaced by an input, so the user can write the state.

It will replace the contents for any select/input that have an id ending with "_state". If you want to control the select/input that must be replaced you use the `state-input-id` data attribute as following:

```ruby
= f_address.input :country, priority: ['BR', 'AR', 'CL', 'PY', 'UY'], input_html: { data: { cs_rails: true, state_input_id: 'target_input_id' } }
```

For now, it's all!

This project rocks and uses MIT-LICENSE.