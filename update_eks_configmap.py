from kubernetes import client, config

CONFIGMAP_NAME = "aws-auth"
NAMESPACE = "kube-system"

def update_configmap(configmap_name, namespace):
    config.load_kube_config()

    v1 = client.CoreV1Api()

    readconfimap = v1.read_namespaced_config_map(configmap_name, namespace)
    # patchconfigmap = v1.patch_namespaced_config_map(configmap_name, namespace, ".")
    return readconfimap

print(update_configmap(CONFIGMAP_NAME, NAMESPACE))