using '../../modules/management-groups/main.bicep'

param displayName = 'Ondfisk Azure Landing Zones'

param prefix = 'lz'

param managementSubscriptionId = '08a54535-3b23-41cb-9ddc-156e4a022912'

param corpSubscriptionIds = []

param onlineSubscriptionIds = [
  '420357e1-748b-4f78-89f2-d4a620ee72ae'
]

param onlineOnboardingSubscriptionIds = []

param sandboxSubscriptionIds = []

param decommissionedSubscriptionIds = []
