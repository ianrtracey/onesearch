module ApiConfig
	REJECTED_VALUES = %w[created_at updated_at deleted_at].map(&:to_sym)
end
