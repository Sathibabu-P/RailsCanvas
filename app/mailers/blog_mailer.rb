class BlogMailer < ApplicationMailer

  def share_blog(blog,user)
    @blog = blog    
    mail(to: user.email, subject: 'Blog Share')
  end

end
