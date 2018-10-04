require 'yaml'
# Module that can be included (mixin) to take and output Yaml data
module YamlBuddy
  # take_tsv: converts a String with YAML data into @data
  # parameter: tsv - a String in YAML format
  def take_yaml(yaml)
    @data = YAML.safe_load(yaml)
  end

  # to_yaml: converts @data into yaml string
  # returns: String in YAML format
  def to_yaml
    @data.to_yaml
  end
end
