require './app/services/builders/article_params_builder.rb'

class ArticlesController < AdminController
  def new
    @translated_category = CategoryTranslation.translation_for(params[:key], current_language_key)

    @translated_conferences = ConferenceTranslation.left_joins(:language, conference: :category)
                                                   .where(categories: { key: params[:key] })
                                                   .where(languages:  { key: current_language_key })
  end

  def create
    article_hash = ArticleParamsBuilder.new(params, current_user).build
    @article = Article.new(article_hash)
    if @article.save
      redirect_to admin_categories_path(@article.category.key), notice: t('admin_articles.save_article_success')
    else
      flash.now[:alert] = t('admin_articles.save_article_error')
      render :new
    end
  end

  def update
    #WIP
  end

  def publish
    article = prepare_article(params[:id])
    article.status = Article::PUBLISHED
    article.publish_date = Time.zone.now

    if article.save
      redirect_to admin_categories_path(article.category_key), notice: t('admin_articles.publish_article_success')
    else
      redirect_to admin_categories_path(article.category_key), alert: t('admin_articles.publish_article_error')
    end
  end

  def unpublish
    article = prepare_article(params[:id])
    article.status = Article::UNPUBLISHED

    if article.save
      redirect_to admin_categories_path(article.category_key), notice: t('admin_articles.unpublish_article_success')
    else
      redirect_to admin_categories_path(article.category_key), alert: t('admin_articles.unpublish_article_error')
    end
  end

  def destroy
    article = Article.left_joins(:category).select('articles.*, categories.key as category_key').find(params[:id])
    article.destroy
    redirect_to admin_categories_path(article.category_key), alert: t('admin_articles.delete_article_success')
  end

  private

  def prepare_article(id)
    ArticleTranslation.left_joins(article: :category)
                      .select('article_translations.*, categories.key as category_key')
                      .find(id)
  end

end
