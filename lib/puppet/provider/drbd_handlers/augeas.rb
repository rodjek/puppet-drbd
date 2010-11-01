require 'augeas' rescue nil

Puppet::Type(:drbd_handlers).provide(:noop) do
  desc ""

  confine :true => File.exists? "/usr/share/augeas/lenses/drbd.aug"

  def initialize(*args)
    super
    @aug = Augeas::open('/', '/usr/share/augeas/lenses', Augeas::NO_MODL_AUTOLOAD)
    @aug.transform(:lens => "Drbd.lns", :incl => "/etc/drbd.conf")
    @aug.load
    @context = "/files/etc/drbd.conf/#{resource[:resource]}"
  end

  def create
    @aug.insert(@context, "handlers", false)
  end

  def destroy
    @aug.rm("#{@context}/handlers")
  end

  def exists?
    @aug.exists("#{@context}/handlers")
  end

  def flush
    @aug.save
  end

  def get_val(key)
    @aug.get("#{@context}/handlers/#{key}")
  end

  def set_val(key, value)
    if value.nil?
      @aug.rm("#{@context}/handlers/#{key}")
    else
      @aug.set("#{@context}/handlers/#{key}", value.to_s)
    end
  end

  def pri_on_incon_degr
    get_val('pri-on-incon-degr')
  end

  def pri_on_incon_degr=(value)
    set_val('pri-on-incon-degr', value)
  end

  def pri_lost_after_sb
    get_val('pri-lost-after-sb')
  end

  def pri_lost_after_sb=(value)
    set_val('pri-lost-after-sb', value)
  end

  def pri_lost
    get_val('pri-lost')
  end

  def pri_lost=(value)
    set_val('pri-lost', value)
  end

  def outdate_peer
    get_val('outdate-peer')
  end

  def outdate_peer=(value)
    set_val('outdate-peer', value)
  end

  def local_io_error
    get_val('local-io-error')
  end

  def local_io_error=(value)
    set_val('local-io-error', value)
  end

  def split_brain
    get_val('split-brain')
  end

  def split_brain=(value)
    set_val('split-brain', value)
  end

  def before_resync_target
    get_val('before-resync-target')
  end

  def before_resync_target=(value)
    set_val('before-resync-target', value)
  end

  def after_resync_target
    get_val('after-resync-target')
  end

  def after_resync_target=(value)
    set_val('after-resync-target', value)
  end
end
