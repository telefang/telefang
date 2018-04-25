def generate_metrics_data(metrics):
    """Given metrics data from a font metrics file, create binary font metrics data."""
    
    assert len(metrics) == 256
    
    return bytes(metrics)