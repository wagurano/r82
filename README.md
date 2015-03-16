액티브 레코드 밸리데이션 실습
----------------------

1. 프로젝트 시작

rails new r82 

1. 제품(Product) 스캐폴드 제너레이터로 제목(문자열), 설명(텍스트), 가격(정수)를 만듭니다.

rails g scaffold Product title description:text value:integer

rake db:migrate

1. 화면에 띄웁니다.

http://localhost:3000

1. 레이아웃을 레일스캐스트 스타일로 적용합니다.

### application.css

<pre>
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

</pre>

### application.html.erb

<pre>
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

</pre>

1. 홈페이지를 제품 목록으로 설정합니다.

### routes.rb

  root 'products#index'

1. 저장을 하면 아무것도 없습니다.

1. 이치 밸리데이터를 사용합니다.

<pre>
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
</pre>

1. 사용자 동의를 선택하는 가상 필드를 만듭니다.

### product_controller.rb

<pre>
    def product_params
      params.require(:product).permit(:title, :description, :value, :are_you_sure)
    end

_form.html.erb

  <div class="field">
    <%= f.label :are_you_sure %>
    <%= f.check_box :are_you_sure %>
  </div>
</pre>

1. 가이드 예시의 이름을 가진 모델 클래스를 만듭니다.

rails g scaffold Person name

rake db:migrate

### person.rb

class Person < ActiveRecord::Base
  validates :name, presence: true
end


1. 참고자료

* [밸리데이션 예시](http://thelucid.com/2010/01/08/sexy-validation-in-edge-rails-rails-3/)

* [레일스 가이드](http://guides.rorlab.org/active_record_validations.html)

