class Redis
  class EmailSignupVerification
    EXPIRE = 259200

    def initialize(opts = {})
      @redis = opts.delete(:redis) || Redis.new(opts)
    end

    def generate(email, password, expire: EXPIRE)
      token = generate_token
      set_key(email, password, token, expire)
      token
    end

    def get(token)
      get_key token
    end

    def email(token)
      @redis.hget(token, "email")
    end

    def password(token)
      @redis.hget(token, "password")
    end

    def created_at(token)
      Time.parse @redis.hget(token, "created_at")
    end

    private

    def set_key(email, password, token, expire)
      @redis.hset(token, "email", email)
      @redis.hset(token, "password", BCrypt::Password.create(password))
      @redis.hset(token, "created_at", Time.now)
      @redis.expire(token, expire)
    end

    def get_key(token)
      {
        token: token,
        email: email(token),
        password: password(token),
        created_at: created_at(token)
      } 
    end

    def generate_token
      SecureRandom.urlsafe_base64 40
    end
  end
end
