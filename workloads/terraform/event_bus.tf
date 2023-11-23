module "critical_alerts_sns_topic" {
  source = "./modules/sns_topics"

  sns_topic_name = "critical_alerts_sns_topic"
  kms_key_id     = "alias/aws/sns"
  e_mail         = "pedro.emidio@datarain.com.br"
}

module "capture_event_bus_events" {
  source = "./modules/hub_account"

  event_bus_name          = "criticalEventsTarget"
  source_event_account_id = ["604828680752", "718814112976"]

  rule_name          = "capture_event_bus_events"
  descripiton_rule   = "Capture event bus events and send to sns topic"
  event_pattern_rule = <<PATTERN
{
  "source": ["aws.events"]
}
PATTERN
  target_id     = "eventBusEvents"
  arn_of_target = module.critical_alerts_sns_topic.arn
}