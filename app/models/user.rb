class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2, :kakao]

    has_many :groups, through: :userlists
    has_many :userlists, dependent: :destroy
    has_many :marks, dependent: :destroy

    # def fandom_lists
    #     self.myfandoms.all&.map{|mf| mf.fandom}
    # end

    # after_create :set_default_role, if: Proc.new { User.count > 1 }


    TEMP_EMAIL_PREFIX = 'change@me'
    TEMP_EMAIL_REGEX = /\Achange@me/
    TEMP_EMAIL_TIMPLE = '@timple.com'

    validates_presence_of :name
    validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

    ## DEVISE OFFICIAL GUIDE
    def self.from_omniauth(auth)
        u = where(provider: auth.provider, uid: auth.uid).first
        if u.nil?
            u = User.create do |user|
                email = auth.info.email
                user.email = email ? email : auth.info.name.gsub(' ','_') + TEMP_EMAIL_TIMPLE
                user.password   = user.email
                user.provider   = auth.provider
                user.uid        = auth.uid
                user.name       = auth.info.name  # assuming the user model has a name
                user.image      = auth.info.image # assuming the user model has an image
                user.img        = auth.info.image
                user.nickname   = user.name
                # If you are using confirmable and the provider(s) you use validate emails,
                # uncomment the line below to skip the confirmation emails.
                # user.skip_confirmation!
            end
        end
    
        return u
    end

    ## GITBOOK GUIDE
    def self.find_for_oauth(auth, signed_in_resource = nil)
    
        # Get the identity and user if they exist
        identity = Identity.find_for_oauth(auth)
    
        # If a signed_in_resource is provided it always overrides the existing user
        # to prevent the identity being locked with accidentally created accounts.
        # Note that this may leave zombie accounts (with no associated identity) which
        # can be cleaned up at a later date.
        user = signed_in_resource ? signed_in_resource : identity.user
    
        # Create the user if needed
        if user.nil?
        
            # Get the existing user by email if the provider gives us a verified email.
            # If no verified email was provided we assign a temporary email and ask the
            # user to verify it on the next step via UsersController.finish_signup
            email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
            email = auth.info.email if email_is_verified
            user = User.where(:email => email).first if email
        
            # Create the user if it's a new registration
            if user.nil?
                user = User.new(
                        name: auth.info.name || auth.extra.nickname ||  auth.uid,
                        email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
                        password: Devise.friendly_token[0,20]
                )
                user.skip_confirmation!
                user.save!
            end
        end
    
        # Associate the identity with the user if needed
        if identity.user != user
            identity.user = user
            identity.save!
        end
    
        user

    end

    def email_verified?
        self.email && self.email !~ TEMP_EMAIL_REGEX
    end

    def my_update_with_password(user_params)
        status = false
        if self.valid_password?(user_params[:current_password])
            user_params.permit!.each do |key, value|
                if value.to_s.length.zero?
                    user_params.except!(key.to_s.to_sym)
                else
                    if key.to_s == 'password'
                        if value != user_params[:password_confirmation]
                            user_params.except!(key.to_s.to_sym)
                            user_params.except!(:password_confirmation)
                            user_params[:password] = user_params[:current_password]
                        end
                    end

                    if key.to_s == 'image'
                        self.update(img: nil)
                    end
                end
                user_params.except!(:current_password)
            end
            status = self.update(user_params)
            # raise :test
        end
    
        return status
    end

    private
    def set_default_role
        add_role :user
    end
end
