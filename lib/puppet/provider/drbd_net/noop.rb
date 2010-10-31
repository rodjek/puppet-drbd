Puppet::Type.type(:drbd_net).provide(:noop) do
  desc "Noop provider"

  confine :false => File.exists? "/usr/share/augeas/lenses/drbd.aug"

  def create
  end

  def destroy
  end

  def exists?
    resource[:ensure] == :present ? true : false
  end

  def sndbuf_size
    resource[:sndbuf_size]
  end

  def sndbuf_size=(value)
  end

  def timeout
    resource[:timeout]
  end

  def timeout=(value)
  end

  def connect_int
    resource[:connect_int]
  end

  def connect_int=(value)
  end

  def ping_int
    resource[:ping_int]
  end

  def ping_int=(value)
  end

  def ping_timeout
    resource[:ping_timeout]
  end

  def ping_timeout=(value)
  end

  def max_buffers
    resource[:max_buffers]
  end

  def max_buffers=(value)
  end

  def max_epoch_size
    resource[:max_epoch_size]
  end

  def max_epoch_size=(value)
  end

  def ko_count
    resource[:ko_count]
  end

  def ko_count=(value)
  end

  def allow_two_primaries
    resource[:allow_two_primaries]
  end

  def allow_two_primaries=(value)
  end

  def cram_hmac_alg
    resource[:cram_hmac_alg]
  end

  def cram_hmac_alg=(value)
  end

  def shared_secret
    resource[:shared_secret]
  end

  def shared_secret=(value)
  end

  def after_sb_0pri
    resource[:after_sb_0pri]
  end

  def after_sb_0pri=(value)
  end

  def after_sb_1pri
    resource[:after_sb_1pri]
  end

  def after_sb_1pri=(value)
  end

  def after_sb_2pri
    resource[:after_sb_2pri]
  end

  def after_sb_2pri=(value)
  end

  def data_integrity_alg
    resource[:data_integrity_alg]
  end

  def data_integrity_alg=(value)
  end

  def no_tcp_cork
    resource[:no_tcp_cork]
  end

  def no_tcp_cork=(value)
  end
end
