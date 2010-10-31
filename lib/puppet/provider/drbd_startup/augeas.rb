require 'augeas' rescue nil

Puppet::Type.type(:drbd_startup).provide(:noop) do
  desc "Augeas provider"

  confine :true => File.exists? "/usr/share/augeas/lenses/drbd.aug"

  def initialize(*args)
    super
    @aug = Augeas.open('/', '/usr/share/augeas/lenses', Augeas::NO_MODL_AUTOLOAD)
    @aug.transform(:lens => 'Drbd.lns', :incl => '/etc/drbd.conf')
    @aug.load
    @context = "/files/etc/drbd.conf/#{resource[:resource]}"
  end

  def create
    @aug.insert(@context, 'startup', false)
  end

  def destroy
    @aug.rm("#{@context}/startup")
  end

  def exists?
    @aug.exists("#{@context}/startup")
  end

  def flush
    @aug.save
  end

  def get_val(key)
    @aug.get("#{@context}/net/#{key}")
  end

  def set_val(key, value)
    if value.nil?
      @aug.rm("#{@context}/net/#{key}")
    else
      @aug.set("#{@context}/net/#{key}", value.to_s)
    end
  end

  def get_bool_val(key)
    @aug.exists("#{@context}/net/#{key}") ? :true | :false
  end

  def set_bool_val(key, value)
    if value == :true
      @aug.insert("#{@context}/net", key, false)
    else
      @aug.rm("#{@context}/net/#{key}")
    end
  end

  def wfc_timeout
    get_val('wfc-timeout')
  end

  def wfc_timeout=(value)
    set_val('wfc-timeout', value)
  end

  def degr_wfc_timeout
    get_val('degr-wfc-timeout')
  end

  def degr_wfc_timeout=(value)
    set_val('degr-wfc-timeout', value)
  end

  def outdated_wfc_timeout
    get_val('outdated-wfc-timeout')
  end

  def outdated_wfc_timeout=(value)
    set_val('outdated-wfc-timeout', value)
  end

  def wait_after_sb
    get_bool_val('wait-after-sb')
  end

  def wait_after_sb=(value)
    set_bool_val('wait-after-sb', value)
  end

  def become_primary_on
    get_val('become-primary-on')
  end

  def become_primary_on=(value)
    set_val('become-primary-on', value)
  end
end
