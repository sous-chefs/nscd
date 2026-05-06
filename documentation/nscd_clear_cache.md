# nscd_clear_cache

Clears one or more nscd database caches.

## Actions

* `:clear` - Runs `nscd -i` for each configured database.

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `databases` | Array | `passwd group hosts services netgroup` | Database caches to clear. |

## Examples

```ruby
nscd_clear_cache 'clear-nscd-caches' do
  databases %w(passwd group)
end
```

```ruby
nscd_clear_cache 'clear-nscd-caches' do
  databases %w(passwd group)
  action :nothing
end

template '/etc/nsswitch.conf' do
  notifies :clear, 'nscd_clear_cache[clear-nscd-caches]', :immediately
end
```
