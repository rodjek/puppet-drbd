require 'augeas' rescue nil

Puppet::Type.type(:drbd_disk).provide(:augeas) do
  desc "Augeas support"

  confine :true => File.exists? "/usr/share/augeas/lenses/drbd.aug"

  def initialize(*args)
    super
    @aug = Augeas::open('/', '/usr/share/augeas/lenses', Augeas::NO_MODL_AUTOLOAD)
    @aug.transform(:lens => "Drbd.lns", :incl => "/etc/drbd.conf")
    @aug.load
    @context = "/augeas/files/etc/drbd.conf/#{resource[:resource]}"
  end

  def flush
    @aug.save
  end

  def create
    @aug.insert(@context, "disk", false)
    self.on_io_error = resource[:on_io_error] unless resource[:on_io_error].nil?
    self.size = resource[:size] unless resource[:size].nil?
    self.fencing = resource[:fencing] unless resource[:fencing].nil?
    self.use_bmbv = resource[:use_bmbv] unless resource[:use_bmbv].nil?
    self.no_disk_flushes = resource[:no_disk_flushes] unless resource[:no_disk_flushes].nil?
    self.no_disk_barrier = resource[:no_disk_barrier] unless resource[:no_disk_barrier].nil?
    self.no_disk_drain = resource[:no_disk_drain] unless resource[:no_disk_drain].nil?
    self.no_md_flushes = resource[:no_md_flushes] unless resource[:no_md_flushes].nil?
    self.max_bio_bvecs = resource[:max_bio_bvecs] unless resource[:max_bio_bvecs].nil?
  end

  def destroy
    @aug.rm(@context)
  end

  def exists?
    @aug.exists?("#{@context}/disk")
  end

  def get_val(key)
    @aug.get("#{@context}/disk/#{key}")
  end

  def set_val(key, value)
    if value.nil?
      @aug.rm("#{@context}/disk/#{key}")
    else
      @aug.set("#{@context}/disk/#{key}", value.to_s)
    end
  end

  def get_bool_val(key)
    @aug.exists("#{@context}/disk/#{key}") ? :true | :false
  end

  def set_bool_val(key, value)
    if value == :true
      @aug.insert("#{@context}/disk", key, false)
    else
      @aug.rm("#{@context}/disk/#{key}")
    end
  end

  def on_io_error
    get_val('on-io-error')
  end

  def on_io_error=(value)
    set_val('on-io-error', value)
  end

  def size
    get_val('size')
  end

  def size=(value)
    set_val('size', value)
  end

  def fencing
    get_val('fencing')
  end

  def fencing=(value)
    set_val('fencing', value)
  end

  def use_bmbv
    get_bool_val('use-bmbv')
  end

  def use_bmbv=(value)
    set_bool_val('use-bmbv', value)
  end

  def no_disk_flushes
    get_bool_val('no-disk-flushes')
  end

  def no_disk_flushes=(value)
    set_bool_val('no-disk-flushes', value)
  end

  def no_disk_barrier
    get_bool_val('no-disk-barrier')
  end

  def no_disk_barrier=(value)
    set_bool_val('no-disk-barrier', value)
  end

  def no_disk_drain
    get_bool_val('no-disk-drain')
  end

  def no_disk_drain=(value)
    set_bool_val('no-disk-drain', value)
  end

  def no_md_flushes
    get_bool_val('no-md-flushes')
  end

  def no_md_flushes=(value)
    set_bool_val('no-md-flushes', value)
  end

  def max_bio_bvecs
    get_val('max-bio-bvecs')
  end

  def max_bio_bvecs=(value)
    set_val('max-bio-bvecs', value)
  end
end
