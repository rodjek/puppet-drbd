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

  def pri_on_incon_degr
    @aug.get("#{@context}/handlers/pri-on-incon-degr")
  end

  def pri_on_incon_degr=(value)
    if value.nil?
      @aug.rm("#{@context}/handlers/pri-on-incon-degr")
    else
      @aug.set("#{@contetx}/handlers/pri-on-incon-degr")
    end
  end

  def pri_lost_after_sb
    @aug.get("#{@context}/handlers/pri-lost-after-sb")
  end

  def pri_lost_after_sb=(value)
    if value.nil?
      @aug.rm("#{@context}/handlers/pri-lost-after-sb")
    else
      @aug.set("#{@context}/handlers/pri-lost-after-sb", value)
    end
  end

  def pri_lost
    @aug.get("#{@context}/handlers/pri-lost")
  end

  def pri_lost=(value)
    if value.nil?
      @aug.rm("#{@context}/handlers/pri-lost")
    else
      @aug.set("#{@context}/handlers/pri-lost", value)
    end
  end

  def outdate_peer
    @aug.get("#{@context}/handlers/outdate-peer")
  end

  def outdate_peer=(value)
    if value.nil?
      @aug.rm("#{@context}/handlers/outdate-peer")
    else
      @aug.set("#{@context}/handlers/outdate-peer", value)
    end
  end

  def local_io_error
    @aug.get("#{@context}/handlers/local-io-error")
  end

  def local_io_error=(value)
    if value.nil?
      @aug.rm("#{@context}/handlers/local-io-error")
    else
      @aug.set("#{@context}/handlers/local-io-error", value)
    end
  end

  def split_brain
    @aug.get("#{@context}/handlers/split-brain")
  end

  def split_brain=(value)
    if value.nil?
      @aug.rm("#{@context}/handlers/split-brain")
    else
      @aug.set("#{@context}/handlers/split-brain", value)
    end
  end

  def before_resync_target
    @aug.get("#{@context}/handlers/before-resync-target")
  end

  def before_resync_target=(value)
    if value.nil?
      @aug.rm("#{@context}/handlers/before-resync-target")
    else
      @aug.set("#{@context}/handlers/before-resync-target", value)
    end
  end

  def after_resync_target
    @aug.get("#{@context}/handlers/after-resync-target")
  end

  def after_resync_target=(value)
    if value.nil?
      @aug.rm("#{@context}/handlers/after-resync-target")
    else
      @aug.set("#{@context}/handlers/after-resync-target", value)
    end
  end
end
