require 'pagy/extras/i18n'
require 'pagy/extras/navs'

Pagy::DEFAULT[:prev_label] = '新しい記事'
Pagy::DEFAULT[:next_label] = '過去の記事'

Rails.logger.info "Pagy initializer loaded"