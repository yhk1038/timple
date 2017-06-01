module TimetablesHelper
    
    def publish_method_label
        private_group ? private_label_format : public_label_format
    end
    
    
    ########
    #
    # HTML Source Bundles
    
    ## > 1-1
    ## 비공개 그룹의 라벨 태그
    def private_label_format
        '<span class="label label-warning">Private</span>'.html_safe
    end
    
    ## > 1-2
    ## 공개 그룹의 라벨 태그
    def public_label_format
        '<span class="label label-danger">Public</span>'.html_safe
    end
    
    protected
    def private_group
        @group.is_private?
    end
end
