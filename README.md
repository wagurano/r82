액티브 레코드 밸리데이션 실습
----------------------

## 프로젝트 시작

    rails new r82 

## 제품(Product) 스캐폴드 제너레이터로 제목(문자열), 설명(텍스트), 가격(정수)를 만듭니다.

    rails g scaffold Product title description:text value:integer

    rake db:migrate

## 화면에 띄웁니다.

    open http://localhost:3000

## 레이아웃을 레일스캐스트 스타일로 적용합니다.

### application.css

```html
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, vendor/assets/stylesheets,
 * or any plugin's vendor/assets/stylesheets directory can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the bottom of the
 * compiled file so the styles you add here take precedence over styles defined in any styles
 * defined in the other CSS/SCSS files in this directory. It is generally better to create a new
 * file per style scope.
 *
 *= require_tree .
 *= require_self
 */

body {
  background: #336699 !important;
}

#header {
  margin:0 auto;
  width:80%;
  text-align: right;

  h1 {
    a {
      color:#5E9DC8;
      font-style: italic;
      text-decoration: none;
      &:hover {
        text-decoration: none;
        background-color: transparent;
      }
    }
  }
}

#trunk {
  width:80%;
  padding:2em 3em;
  margin:0 auto;
  border:2px solid #0C2C52;
  background: white;
}

#footer {
  width:80%;
  margin:10px auto;
  color:#5E9DC8;
  text-align: center;
}
```

### application.html.erb

```html
    <body>
    
    <div id="header">
      <h1><%= linkt_to "ROR Lab", root_path %></h1>
    </div>
    
    <div id="trunk">
      <%= yield %>
    </div>
    
    <div id="footer">
      - Biweekly Lecture on <%= Date.today %> -
    </div>
    
    </body>
```

## 홈페이지를 제품 목록으로 설정합니다.

### routes.rb

    root 'products#index'

## 저장을 하면 아무것도 없습니다.

## 이치 밸리데이터를 사용합니다.

```ruby
    class TitleValidator < ActiveModel::EachValidator
      def validate_each record, attribute, value
        record.errors[:title] = "Title must be started with capital." unless value =~ /\A[A-Z]/
      end
    end
    
    class Product < ActiveRecord::Base
      validates :description, :value, presence: true
      validates :value, numericality: { greater_than_or_equal_to: 100, less_than_or_equal_to: 1000 }
      validates :are_you_sure, acceptance: true
      validates :title, presence: true, title: true
    end
```

## 사용자 동의를 선택하는 가상 필드를 만듭니다.

### product_controller.rb

```ruby
    def product_params
      params.require(:product).permit(:title, :description, :value, :are_you_sure)
    end
```

### _form.html.erb

```html
    <div class="field">
      <%= f.label :are_you_sure %>
      <%= f.check_box :are_you_sure %>
    </div>
```

## 가이드 예시의 이름을 가진 모델 클래스를 만듭니다.

    rails g scaffold Person name
    
    rake db:migrate

### person.rb

```ruby
    class Person < ActiveRecord::Base
      validates :name, presence: true
    end
```

## 참고자료

* [밸리데이션 예시](http://thelucid.com/2010/01/08/sexy-validation-in-edge-rails-rails-3/)

* [레일스 가이드](http://guides.rorlab.org/active_record_validations.html)


* acceptance
* validates_associated
* confirmation
* exclusion
* format
* inclusion
* length
* numericality
* presence
* absence
* uniqueness
* validates_with
* validates_each

### acceptance


### validates_associated

http://stackoverflow.com/questions/6395506/when-to-use-validates-associated-v-belongs-to-parent-validate-true

rails g model user username
rails g model absent_date user:references

rake db:migrate

```ruby
    class User < ActiveRecord::Base
        has_many :assent_date, autosave: true
        alidates :username, presence: true
    end
    
    class AbsentDate < ActiveRecord::Base
        # 1
        # belongs_to :user, autosave: true, validate: true
        
        # 2
        belongs_to :user
        validates_associated :user
    end
    
    user1 = User.new username: "rorla"
    user1.valid? # true
    user1.save
    ad1 = AbsentDate.new user: user1
    user1.username = nil
    user1.valid? # false
    ad1.valid? # false
    ad1.errors.full_messages
    ad1.user.delete
    ad1.valid? # true
    
    user2 = User.new username: "weekly"
    user2.valid? # true
    user2.save
    ad2 = AbsentDate.new user: user2
    user2.username = nil
    user2.valid? # false
    ad2.valid? # false
    
    ad2.errors.full_messages
    ad2.user.delete 
    ad2.valid? # false
```



### confirmation
email confirmantion

rails g migrate add_email_to_person email:string
rake db:migrate

people_controller.rb

````ruby
    def person_params
        params.require(:person).permit(:name, :email, :email_confimation)
    end
    
    class Person < ActiveRecord::Base
        validates :name, :email, presence: true
        validates :email, confirmation: true
        validates :email_confirmation, presence: true
    end
    
    validates :email, confirmation: true
validates :email_confirmation, presence: true
````

재입력하는 가상 속성에도 존재유무를 확인하는 밸리데이션을 하나 더 써야 한다.

````ruby
    class Person < ActiveRecord::Base
        validates :name, :email, presence: true
        validates :email, confirmation: true
        # validates :email_confirmation, presence: true
    end
````

/ gender ex
/ rails g migration add_gender_to_person gender:string


### exclusion

````validates :name, exclustion: { in: %w(admin root) }


rails g migration add_language_to_person language:string

rake db:migrate

person.rb
````validates :language, inclusion: { in: I18n.available_locales.map(&:to_s) }



presence 를 모델관계에 쓰는 예시

http://railsguides.net/belongs-to-and-presence-validation-rule1/


### format

### inclusion

### length

### numericality

### presence

### absence

### uniqueness

### validates_with

### validates_each


