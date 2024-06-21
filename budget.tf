resource "aws_budgets_budget" "Bolt" {
  name              = "My Zero-Spend Budget for Bolt"
  budget_type       = "COST"
  limit_amount      = "0.01"
  limit_unit        = "USD"
  time_period_start   = "2024-06-21_00:00"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 0.01
    threshold_type             = "ABSOLUTE_VALUE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["givoyiw392@elahan.com"]
  }
}