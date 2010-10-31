require 'augeas' rescue nil

Puppet::Type.type(:drbd_net).provide(:noop) do
  desc "Augeas support"

  confine :false => File.exists? "/usr/share/augeas/lenses/drbd.aug"

  def initialize(*args)
    super
    @aug = Augeas.open('/', '/usr/share/augeas/lenses', Augeas::NO_MODL_AUTOLOAD)
    @aug.transform(:lens => "Drbd.lns", :incl => "/etc/drbd.conf")
    @aug.load
    @context = "/files/etc/drbd.conf/#{resource[:resource]}"
  end

  def flush
    @aug.save
  end

  def create
    @aug.insert(@context, "net", false)
  end

  def destroy
    @aug.rm("#{@context}/net")
  end

  def exists?
    @aug.exists("#{@context}/net")
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

  def sndbuf_size
    get_val("sndbuf-size")
  end

  def sndbuf_size=(value)
    set_val("sndbuf-size", value)
  end

  def timeout
    get_val("timeout")
  end

  def timeout=(value)
    set_val("timeout", value)
  end

  def connect_int
    get_val("connect-int")
  end

  def connect_int=(value)
    set_val("connect-int", value)
  end

  def ping_int
    get_val("ping-int")
  end

  def ping_int=(value)
    set_val("ping-int", value)
  end

  def ping_timeout
    get_val("ping-timeout")
  end

  def ping_timeout=(value)
    set_val("ping-timeout", value)
  end

  def max_buffers
    get_val("max-buffers", value)
  end

  def max_buffers=(value)
    set_val("max-buffers", value)
  end

  def max_epoch_size
    get_val("max-epoch-size")
  end

  def max_epoch_size=(value)
    set_val("max-epoch-size", value)
  end

  def ko_count
    get_val("ko-count")
  end

  def ko_count=(value)
    set_val("ko-count", value)
  end

  def allow_two_primaries
    get_bool_val('allow-two-primaries')
  end

  def allow_two_primaries=(value)
    set_bool_val('allow-two-primaries', value)
  end

  def cram_hmac_alg
    get_val("cram-hmac-alg")
  end

  def cram_hmac_alg=(value)
    set_val("cram-hmac-alg", value)
  end

  def shared_secret
    get_val('shared-secret')
  end

  def shared_secret=(value)
    set_val('shared-secret', value)
  end

  def after_sb_0pri
    get_val('after-sb-0pri')
  end

  def after_sb_0pri=(value)
    set_val('after-sb-0pri', value)
  end

  def after_sb_1pri
    get_val('after-sb-1pri')
  end

  def after_sb_1pri=(value)
    set_val('after-sb-1pri', value)
  end

  def after_sb_2pri
    get_val('after-sb-2pri')
  end

  def after_sb_2pri=(value)
    set_val('after-sb-2pri', value)
  end

  def data_integrity_alg
    get_val('data-integrity-alg')
  end

  def data_integrity_alg=(value)
    set_val('data-integrity-alg', value)
  end

  def no_tcp_cork
    get_bool_val('no-tcp-cork')
  end

  def no_tcp_cork=(value)
    set_bool_val('no-tcp-cork', value)
  end
end
