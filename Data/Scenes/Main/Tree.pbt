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
  ChildIds: 16283546463645705078
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
  Id: 16283546463645705078
  Name: "NFT Loot Drop"
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
  ParentId: 4781671109827199097
  UnregisteredParameters {
    Overrides {
      Name: "cs:CollectionAddress"
      String: "0xca590be85a184b8ed837b28966602d543569e41f"
    }
    Overrides {
      Name: "cs:CrateSpawnPoints"
      ObjectReference {
        SelfId: 1030559185868980364
      }
    }
    Overrides {
      Name: "cs:CrateZStartPoint"
      Float: 2000
    }
    Overrides {
      Name: "cs:WalletItemChance"
      Float: 10
    }
    Overrides {
      Name: "cs:CollectionItemChance"
      Float: 0
    }
    Overrides {
      Name: "cs:NoLootItem"
      AssetReference {
        Id: 14553213536522306652
      }
    }
    Overrides {
      Name: "cs:CrateZStartPoint:tooltip"
      String: "The Z position of the crate when it spawns in. The crate will be moved down over time to the area point."
    }
    Overrides {
      Name: "cs:CrateSpawnPoints:isrep"
      Bool: false
    }
    Overrides {
      Name: "cs:CrateSpawnPoints:ml"
      Bool: false
    }
  }
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
    FilePartitionName: "NFT Loot Drop"
  }
  NetworkRelevanceDistance {
    Value: "mc:eproxyrelevance:critical"
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
