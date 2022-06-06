Name: "Root"
RootId: 4781671109827199097
Objects {
  Id: 4781671109827199097
  Name: "Root"
  Transform {
    Location {
    }
    Rotation {
    }
    Scale {
      X: 1
      Y: 1
      Z: 1
    }
  }
  ChildIds: 6091589806862136508
  ChildIds: 4678680307045302864
  ChildIds: 1508782722951315297
  UnregisteredParameters {
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:forceon"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:forceon"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Folder {
  }
  NetworkRelevanceDistance {
    Value: "mc:eproxyrelevance:critical"
  }
}
Objects {
  Id: 1508782722951315297
  Name: "Fantasy Castle 01"
  Transform {
    Scale {
      X: 1
      Y: 1
      Z: 1
    }
  }
  ParentId: 4781671109827199097
  TemplateInstance {
    ParameterOverrideMap {
      key: 10167810835038990481
      value {
        Overrides {
          Name: "Name"
          String: "Fantasy Castle 01"
        }
        Overrides {
          Name: "Position"
          Vector {
            X: 200.128357
            Y: -67.3516541
            Z: 2.28881836e-05
          }
        }
      }
    }
    TemplateAsset {
      Id: 1560568249585282468
    }
  }
}
Objects {
  Id: 4678680307045302864
  Name: "NFT Loot Drop"
  Transform {
    Scale {
      X: 1
      Y: 1
      Z: 1
    }
  }
  ParentId: 4781671109827199097
  TemplateInstance {
    ParameterOverrideMap {
      key: 6431221970264818303
      value {
        Overrides {
          Name: "Position"
          Vector {
            Y: 74.0003662
            Z: 873.898621
          }
        }
      }
    }
    ParameterOverrideMap {
      key: 13184223503303680389
      value {
        Overrides {
          Name: "Name"
          String: "NFT Loot Drop"
        }
        Overrides {
          Name: "cs:CollectionAddress"
          String: "0x5b18c2b5979854411cbfb2f1ba8ffbb03cad2c1e"
        }
        Overrides {
          Name: "cs:CollectionItemChance"
          Float: 50
        }
        Overrides {
          Name: "cs:WalletItemChance"
          Float: 50
        }
      }
    }
    TemplateAsset {
      Id: 6284578282830536335
    }
  }
}
Objects {
  Id: 6091589806862136508
  Name: "Misc"
  Transform {
    Location {
      Z: -50
    }
    Rotation {
    }
    Scale {
      X: 1
      Y: 1
      Z: 1
    }
  }
  ParentId: 4781671109827199097
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  EditorIndicatorVisibility {
    Value: "mc:eindicatorvisibility:visiblewhenselected"
  }
  Folder {
    IsFilePartition: true
    FilePartitionName: "Misc"
  }
  NetworkRelevanceDistance {
    Value: "mc:eproxyrelevance:critical"
  }
}
